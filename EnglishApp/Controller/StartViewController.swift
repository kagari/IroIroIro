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
        super.viewDidLoad()
        let view = StartView()
        view.delegate = self // delegateをセット
        self.view = view
    }
    
    // Startボタンが押されたときには呼ばれる
    func didTapStartButton() {
        print("Startボタンがタップされた")
        let questionViewController = QuestionViewController(titleName: "QuestionViewController")
        questionViewController.modalPresentationStyle = .fullScreen
        self.present(questionViewController, animated: true, completion: nil)
    }
}

