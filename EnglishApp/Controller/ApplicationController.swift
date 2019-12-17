import Foundation
import UIKit
import AVFoundation

class ApplicationController: UIViewController, ARViewDelegate {
    
    private var startView: StartView!
    private var howToView: HowToView!
    private var rewardView: RewardView!
    private var questionView: QuestionView!
    private var arView: ARView!
    private var resultView: ResultView!
    private var questionData: QuestionData!
    private var questionAlphabetIndex: Int!
    private let rewardData = RewardData()
    private var identifier: String!
    var question: String?
    
    private var gameClearCount: Int!
    private var isSpellJudge: Bool!
    
    var speechSynthesizer: AVSpeechSynthesizer!
    var audioPlayer: AVAudioPlayer!
    let audioCorrect = NSDataAsset(name: "correct1")
    let audioIncorrect = NSDataAsset(name: "incorrect1")
    
    // set instance for game
    private func setupGame() {
        self.startView = StartView()
        self.howToView = HowToView()
        self.rewardView = RewardView()
        self.questionView = QuestionView()
        self.arView = ARView()
        self.resultView = ResultView()
        self.questionData = QuestionData()
        self.questionAlphabetIndex = 0
        
        self.startView.delegate = self
        self.howToView.delegate = self
        self.rewardView.delegate = self
        self.arView.delegate = self
        self.resultView.delegate = self
        self.questionView.delegate = self
        
        self.question = self.questionData.getQuestion()
        
        self.speechSynthesizer = AVSpeechSynthesizer()
        self.isSpellJudge = false
        
        if self.gameClearCount == nil || self.gameClearCount == 5 {
            self.gameClearCount = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGame()
        self.view = self.startView
    }
    
    // MARK: - 物体認識画面の画面タップ時の挙動
    func tapGesture(identifier: String?) {
        print("Get Tap Gesture!")
        print("identifier: \(String(describing: identifier))")
        
        self.identifier = identifier
        
        guard let targetAlphabet = self.getAlphabet(index: self.questionAlphabetIndex) else {
            print("targetAlphabet is nil...")
            return
        }
        
        guard let isContain = self.checkObjectNameAndQuestion(identifier: identifier, targetAlphabet: String.Element(targetAlphabet)) else {
            print("checkObjectNameAndQuestion function return nil...")
            return
        }
        
        if self.isSpellJudge {
            return
        }
        
        self.isSpellJudge = true
        
        if let identifier = self.identifier {
            let utterance = AVSpeechUtterance(string: identifier) // 読み上げるtext
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // 言語
            utterance.rate = 0.5; // 読み上げ速度
            utterance.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
            utterance.preUtteranceDelay = 0.2; // 読み上げるまでのため
            self.speechSynthesizer.speak(utterance)
        }
        
        // すでに使われている単語だった場合は処理をしない
        if self.questionData.getUsedTextList().firstIndex(of: identifier!) != nil {
            // すでに使われている単語をタップした時も、失敗判定にする
            do {
                audioPlayer = try AVAudioPlayer(data: audioIncorrect!.data, fileTypeHint: "mp3")
                audioPlayer.volume = 0.1
            } catch {
                print("AVAudioPlayerインスタンス作成でエラー")
            }
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            self.arView.setAlert(callback: { self.isSpellJudge = false })
            
            return
        }
        
        if isContain {
            print("targetAlphabet: \(targetAlphabet) in identifier: \(String(describing: identifier))!!")
            print("Correct!!")
            
            self.arView.setCorrectLabel() //まる表示
            // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
            do {
                audioPlayer = try AVAudioPlayer(data: audioCorrect!.data, fileTypeHint: "mp3")
                audioPlayer.volume = 0.1
            } catch {
                print("AVAudioPlayerインスタンス作成でエラー")
            }
            audioPlayer.prepareToPlay() // 再生準備
            audioPlayer.play() // 再生
            
            
            self.questionData.addUsedText(usedText: identifier)
            
            self.questionAlphabetIndex += 1
            // when Next alphabet is none, goto ResultView
            if self.questionAlphabetIndex == self.question?.lengthOfBytes(using: String.Encoding.utf8) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.arView.pauseSession()
                    self.gameClearCount += 1
                    self.toResultView()
                    self.identifier = nil
                    self.isSpellJudge = false
                }
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                //                self.arView.pauseSession()
                self.toQuestionView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.identifier = nil
                    self.isSpellJudge = false
                    self.toARView()
                }
            }
            
        }else{ //間違えUIここ
            
            self.arView.setWrongLabel() //ばつ表示
            // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
            do {
                audioPlayer = try AVAudioPlayer(data: audioIncorrect!.data, fileTypeHint: "mp3")
                audioPlayer.volume = 0.1
            } catch {
                print("AVAudioPlayerインスタンス作成でエラー")
            }
            audioPlayer.prepareToPlay() // 再生準備
            audioPlayer.play() // 再生
            
            print("targetAlphabet: \(targetAlphabet) not in identifier: \(String(describing: identifier))!!")
            print("Incorrect!!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.identifier = nil
                self.isSpellJudge = false
                self.toARView()
            }
        }
    }
    
    // MARK: - その他の関数
    func toARView() {
        self.arView.subviews.forEach { subview in
            if subview.tag >= 10 {
                subview.removeFromSuperview()
            }
        }
        self.arView.startSession()
        self.view = self.arView
        self.arView.setQuestionLabel(question: self.question, index: self.questionAlphabetIndex)
    }
    
    func toQuestionView() {
        self.arView.subviews.forEach { subview in
            if subview.tag >= 10 {
                subview.removeFromSuperview()
            }
        }
        let alphabet = self.getAlphabet(index: self.questionAlphabetIndex)
        self.view = self.questionView
        self.questionView.setQuestionLabel(questionString: self.question, questionAlphabet: alphabet, idx: self.questionAlphabetIndex!)
        self.questionView.setQuestionImage(name: self.question!)
    }
    
    func toResultView() {
        self.resultView.setQuestionLabel(question: self.question)
        self.view = self.resultView
        self.resultView.setUsedTextLabels(usedTexts: self.questionData.getUsedTextList(), question: self.question)
        
        self.resultView.setClearStars(clearCount: self.gameClearCount)
        
        if self.gameClearCount == 5 {
            self.resultView.setRewardWindow(reward: self.rewardData.getReward())
        }
    }
    
    func checkObjectNameAndQuestion(identifier: String?, targetAlphabet: String.Element) -> Bool? {
        // ignore Capital or Lower Case when check alphabet
        guard let isContain = identifier?.lowercased().contains(targetAlphabet.lowercased()) else {
            print("identifier is nil!")
            return nil
        }
        return isContain
    }
    
    // get n-th alphabet from question
    func getAlphabet(index: Int) -> String? {
        guard let count = self.question?.count else {
            return nil
        }
        
        if count > index {
            return self.question?.map({String($0)})[index]
        }
        
        return nil
    }
}

extension ApplicationController: StartViewDelegate {
    func buttonEvent(_: UIButton) {
        print("Pushed Start Button!")
        self.toQuestionView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            self.toARView()
        }
    }
    
    func goHowTo(_: UIButton) {
        print("Pushed HowTo Button!")
        self.view = self.howToView
    }
    
    func goSetting(_: UIButton) {
        print("Pushed Setting Button!")
        self.rewardView.setTextField(reward: self.rewardData.getReward())
        self.view = self.rewardView
        
        // 保護者に報酬を設定させるように促すポップアップ画面の初期化
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let popUpView = PopUpView(frame: CGRect(x: 0, y: 0, width: width*0.8, height: height*0.2))
        popUpView.center = self.rewardView.center
        self.rewardView.addSubview(popUpView)
    }
}

extension ApplicationController: HowToViewDelegate {
    func onbackClick(_: UIButton) {
        print("Pushed Back Button!")
        self.setupGame()
        self.view = self.startView
    }
}

extension ApplicationController: RewardViewDelegate {
    func goSave(reward: String?) {
        print("Pushed save Button!")
        self.rewardData.setReward(reward: reward)
    }
}

extension ApplicationController: ResultViewDelegate {
    func goHome(_: UIButton) {
        print("Pushed おわり Button!")
        self.setupGame()
        self.view = self.startView
    }
    
    func goNextGame(_: UIButton) {
        print("Pushed もういちど Button!")
        self.setupGame()
        
        self.toQuestionView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.toARView()
        }
    }
}

extension ApplicationController: QuestionViewDelegate{
    func goSkip(_: UIButton) {
        print("Pushed Skip Button!")
        self.toARView()
    }
    
}
