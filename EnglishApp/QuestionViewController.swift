//
//  Question.swift
//  ARKit3DTextSample
//
//  Created by 新垣結梨 on 2019/10/19.
//  Copyright © 2019 SAPPOROWORKS. All rights reserved.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel! // お題用のラベル
    let questions = ["Phone", "Dog", "Cat", "Hoge", "Terminal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        let string = questions[3]
        let labels = make_label(string: string, view: self.view)
        for label in labels {
            self.view.addSubview(label)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // 3秒後にARの画面に遷移
            self.performSegue(withIdentifier: "toARViewController", sender: nil)
        }
    }
    
    // MARK: - UIを整える関数
    private func setupUI() {
        question.text = "DOG"
        question.textColor = .purple
        question.textAlignment = .center
        question.font = UIFont.systemFont(ofSize: 100.0)
    }
}
