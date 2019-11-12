import Foundation
import UIKit

class ApplicationController: UIViewController, StartViewDelegate, HowToViewDelegate, ARViewDelegate {
    
    let startView = StartView()
    let howToView = HowToView()
    let questionViewController = QuestionViewController()
    let resutltViewController = ResultViewController()
    let arView = ARView()
    var questionAlphabetIndex = 0
    var identifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startView.delegate = self
        howToView.delegate = self
        arView.delegate = self
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
        self.view = howToView
    }
    
    func goSetting(_: UIButton) {
        print("Pushed Setting Button!")
    }
    
    // MARK: - HowTo画面のボタンタップ時の挙動
    func onbackClick(_: UIButton) {
        print("Pushed Back Button!")
        self.view = startView
    }
    
    // MARK: - 物体認識画面の画面タップ時の挙動
    func tapGesture(identifier: String?) {
        print("Get Tap Gesture!")
        print("identifier: \(String(describing: identifier))")
        
        self.identifier = identifier
        
        guard let targetAlphabet = self.questionViewController.getAlphabet(index: self.questionAlphabetIndex) else {
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
            
            
            self.questionViewController.setUsedObjectName(objectName: identifier)
            
            self.questionAlphabetIndex += 1
            // when Next alphabet is none, goto ResultView
            if self.questionAlphabetIndex == self.questionViewController.question?.lengthOfBytes(using: String.Encoding.utf8) {
                self.arView.pauseSessionRun() // ARsession Pause
                
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
        self.arView.startSessionRun()
        self.view = self.arView
    }
    
    func toQuestionView() {
        questionViewController.index = self.questionAlphabetIndex
        questionViewController.setUpView()
        self.view = questionViewController.questionView
    }
    
    func toResultView() {
        self.resutltViewController.resultQuestionView.setQuestionLabel()
        self.view = self.resutltViewController.resultQuestionView
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.resutltViewController.resultUsedTextView.setUsedTextLabels()
            self.view = self.resutltViewController.resultUsedTextView
        }
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
