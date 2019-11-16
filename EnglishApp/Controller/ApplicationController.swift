import Foundation
import UIKit

class ApplicationController: UIViewController, StartViewDelegate, HowToViewDelegate, ARViewDelegate {
    
    private var startView: StartView!
    private var howToView: HowToView!
    private var questionView: QuestionView!
    private var arView: ARView!
    private var resultView: ResultView!
    private var questionData: QuestionData!
    private var questionAlphabetIndex: Int!
    private var identifier: String!
    var question: String?
    
    // set instance for game
    private func setupGame() {
        self.startView = StartView()
        self.howToView = HowToView()
        self.questionView = QuestionView()
        self.arView = ARView()
        self.resultView = ResultView()
        self.questionData = QuestionData()
        self.questionAlphabetIndex = 0
        
        self.startView.delegate = self
        self.howToView.delegate = self
        self.arView.delegate = self
        
        self.question = self.questionData.getQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGame()
        
        self.view = startView
    }
    
    // MARK: - Start画面のボタンタップ時の挙動
    func buttonEvent(_: UIButton) {
        print("Pushed Start Button!")
        self.toQuestionView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.toARView()
        }
    }
    
    func goHowTo(_: UIButton) {
        print("Pushed HowTo Button!")
        self.view = self.howToView
    }
    
    func goSetting(_: UIButton) {
        print("Pushed Setting Button!")
    }
    
    // MARK: - HowTo画面のボタンタップ時の挙動
    func onbackClick(_: UIButton) {
        print("Pushed Back Button!")
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
        
        if isContain { //ここで正誤判定の結果をUIで表示する
            print("targetAlphabet: \(targetAlphabet) in identifier: \(String(describing: identifier))!!")
            print("Correct!!")
            
            let maru = UILabel()
            maru.text = "⭕️"
            //maru.textColor = UIColor(rgb: 0xFF65B2)
            maru.font = UIFont(name: "Menlo", size: 100)
            maru.frame = CGRect(x: 300, y: 300, width: 500, height: 500)
            maru.sizeToFit()
            maru.textAlignment = .center
            self.arView.addSubview(maru)
            
            self.questionData.addUsedText(usedText: identifier)
            
            self.questionAlphabetIndex += 1
            // when Next alphabet is none, goto ResultView
            if self.questionAlphabetIndex == self.question?.lengthOfBytes(using: String.Encoding.utf8) {
                self.toResultView()
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.toQuestionView()
                self.toARView()
            }
            
        }else{ //間違えUIここ
            let batsu = UILabel()
            batsu.text = "✖️"
            batsu.font = UIFont(name: "Menlo", size: 100)
            batsu.frame = CGRect(x: 300, y: 300, width: 500, height: 500)
            batsu.sizeToFit()
            batsu.textAlignment = .center
            self.arView.addSubview(batsu)
            print("targetAlphabet: \(targetAlphabet) not in identifier: \(String(describing: identifier))!!")
            print("Incorrect!!")
            
            
            
        }
    }
    
    // MARK: - その他の関数
    func toARView() {
        self.arView.startSession()
        self.view = self.arView
        self.arView.setQuestionLabel(question: self.question)
    }
    
    func toQuestionView() {
        let alphabet = self.getAlphabet(index: self.questionAlphabetIndex)
        self.questionView.setQuestionLabel(questionString: self.question, questionAlphabet: alphabet)
        self.view = self.questionView
    }
    
    func toResultView() {
        self.resultView.setQuestionLabel(question: self.question)
        self.resultView.setUsedTextLabels(usedTexts: self.questionData.getUsedTextList())
        self.view = self.resultView
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
        return question?.map({String($0)})[index]
    }
}
