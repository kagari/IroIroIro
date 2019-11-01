//
//  StartViewController.swift
//  EnglishApp
//
//  Created by 大城昂希 on 2019/10/31.
//

import Foundation
import UIKit

class StartViewController: UIViewController, StartViewDelegate {
    
    override func viewDidLoad() {
        print("StartViewControllerが呼ばれた")
        super.viewDidLoad()
        let view = StartView()
        view.delegate = self
        self.view = view
    }
    
    // Startボタンが押されたときには呼ばれる
    func didTapStartButton() {
        print("お題へ画面遷移")
        let questionViewController = QuestionViewController()
        questionViewController.modalPresentationStyle = .fullScreen
        self.present(questionViewController, animated: true, completion: nil)
    }
}

