import Foundation
import UIKit

class ApplicationController: UIViewController, StartViewDelegate, HowToViewDelegate, ARViewDelegate {
    
    private var startView: StartView!
    private var howToView: HowToView!
    private var questionView: QuestionView!
    private var arView: ARView!
    private var resultView: ResultView!
    private var questionModel: QuestionModel!
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
        self.questionModel = QuestionModel()
        self.questionAlphabetIndex = 0
        
        self.startView.delegate = self
        self.howToView.delegate = self
        self.arView.delegate = self
        
        self.resultView.dataSource = self.questionModel
        
        self.question = self.questionModel.questionString
    }
    
    func getAlphabet(index: Int) -> String? {
        // get n-th alphabet from question
        return question?.map({String($0)})[index]
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
        
        if isContain {
            self.arView.pauseSession()
            print("targetAlphabet: \(targetAlphabet) in identifier: \(String(describing: identifier))!!")
            print("Correct!!")
            
            self.questionModel.saveUsedText(string: identifier)
            
            self.questionAlphabetIndex += 1
            // when Next alphabet is none, goto ResultView
            if self.questionAlphabetIndex == self.question?.lengthOfBytes(using: String.Encoding.utf8) {
                self.toResultView()
                return
            }
            
            self.toQuestionView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.toARView()
            }
            
        }else{
            print("targetAlphabet: \(targetAlphabet) not in identifier: \(String(describing: identifier))!!")
            print("Incorrect!!")
        }
    }
    
    // MARK: - その他の関数
    func toARView() {
        self.arView.setQuestionLabel(question: self.question)
        self.arView.startSession()
        self.view = self.arView
    }
    
    func toQuestionView() {
        self.questionView.setQuestionLabel(questionString: self.question, questionAlphabet: self.getAlphabet(index: self.questionAlphabetIndex))
        self.view = self.questionView
    }
    
    func toResultView() {
        self.resultView.setQuestionLabel()
        self.resultView.setUsedTextLabels()
        self.view = self.resultView
    }
    
    func checkObjectNameAndQuestion(identifier: String?, targetAlphabet: String.Element) -> Bool? {
        //大文字小文字を無視させて評価
        guard let isContain = identifier?.lowercased().contains(targetAlphabet.lowercased()) else {
            print("identifier is nil!")
            return nil
        }
        return isContain
    }
}
