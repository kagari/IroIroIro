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
        
        let string = "DOG"
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
    
    private func make_label(string: String, view: UIView) -> [UILabel] {
        let length = string.lengthOfBytes(using: String.Encoding.utf8)
        let label_size = view.frame.size.width/CGFloat(length) - CGFloat(50)
        var x = CGFloat(0.0)
        let uilabels = string.map({(spell) -> UILabel in
            x += CGFloat(30)
            let label = UILabel(frame: CGRect(x: x, y: 10, width: label_size, height: label_size))
            x += label_size + CGFloat(5)
            // 角を丸くする
            label.layer.cornerRadius = label_size/2
            label.clipsToBounds = true
            // 枠線を表示
            label.layer.borderWidth = 10.0
            label.layer.borderColor = UIColor.gray.cgColor
            // 文字の位置のセンタリングやバックグラウンドの設定
            label.backgroundColor = .white
            label.textAlignment = .center
            label.text = String(spell)
            label.font = UIFont(name: "Times New Roman", size: 100)
            return label
        })
        return uilabels
    }
}
