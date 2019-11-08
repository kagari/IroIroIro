import Foundation
import UIKit

class ApplicationController: UIViewController, StartViewDelegate, HowToViewDelegate {
    
    let startView = StartView()
    let howToView = HowToView()
    let questionViewController = QuestionViewController()
    let arViewController = ARViewController()
    var questionAlphabetIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startView.delegate = self
        howToView.delegate = self
        self.view = startView
    }
    
    // MARK: - Start画面のボタンタップ時の挙動
    func buttonEvent(_: UIButton) {
        print("Pushed Start Button!")
        questionViewController.index = self.questionAlphabetIndex
        questionViewController.setUpView()
        self.view = questionViewController.questionView
        self.toARView()
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
    
    func toARView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.view = self.arViewController
            self.arViewController.startSessionRun()
            // 3秒後にResult画面に遷移
//            let arSearchObjectViewController = ARSearchObjectViewController()
//            arSearchObjectViewController.modalPresentationStyle = .fullScreen
//            self.present(arSearchObjectViewController, animated: true, completion: nil)
        }
    }
}
