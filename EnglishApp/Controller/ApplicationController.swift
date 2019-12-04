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
    
    var speechSynthesizer : AVSpeechSynthesizer!
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
        self.gameClearCount = 0
        
        self.startView.delegate = self
        self.howToView.delegate = self
        self.rewardView.delegate = self
        self.arView.delegate = self
        self.resultView.delegate = self
        
        self.question = self.questionData.getQuestion()
        
        self.speechSynthesizer = AVSpeechSynthesizer()
        self.isSpellJudge = false
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
                self.identifier = nil
                self.isSpellJudge = false
                self.arView.pauseSession()
                self.toResultView()
                self.gameClearCount += 1
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.identifier = nil
                self.isSpellJudge = false
                self.arView.pauseSession()
                self.toQuestionView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
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
                self.isSpellJudge = false
                self.toARView()
            }
        }
    }
    
    // MARK: - その他の関数
    func toARView() {
        self.arView.subviews.forEach { subview in
            if subview.tag == 0 && subview is UILabel {
                subview.removeFromSuperview()
            }
        }
        self.arView.startSession()
        self.view = self.arView
        self.arView.setQuestionLabel(question: self.question, index: self.questionAlphabetIndex)
    }
    
    func toQuestionView() {
        let alphabet = self.getAlphabet(index: self.questionAlphabetIndex)
        self.questionView.setQuestionLabel(questionString: self.question, questionAlphabet: alphabet)
        self.view = self.questionView
    }
    
    func toResultView() {
        self.resultView.setQuestionLabel(question: self.question)
        self.view = self.resultView
        self.resultView.setUsedTextLabels(usedTexts: self.questionData.getUsedTextList(), question: self.question)
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
        return self.question?.map({String($0)})[index]
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
    }
}

extension ApplicationController: HowToViewDelegate {
    func onbackClick(_: UIButton) {
        print("Pushed Back Button!")
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
