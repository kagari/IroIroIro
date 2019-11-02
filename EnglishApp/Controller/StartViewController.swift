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
        print("Called: StartViewController")
        super.viewDidLoad()
        let view = StartView()
        view.delegate = self
        self.view = view
    }
    
    // Startボタンが押されたときには呼ばれる
    func didTapStartButton() {
        let questionViewController = QuestionViewController()
        questionViewController.modalPresentationStyle = .fullScreen
        self.present(questionViewController, animated: true, completion: nil)
    }
}

