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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    // MARK: - UIを整える関数
    private func setupUI() {
        question.text = "DOG"
        question.textColor = .purple
        question.textAlignment = .center
        question.font = UIFont.systemFont(ofSize: 100.0)
    }
}
