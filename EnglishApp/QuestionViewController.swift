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
        
//        self.setupUI()
        
        let string = "Phone"
        let labels = make_label(string: string, view: self.view)
        for label in labels {
            self.view.addSubview(label)
        }
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            // 3秒後にARの画面に遷移
//            self.performSegue(withIdentifier: "toARViewController", sender: nil)
//        }
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
        let frame_width = view.frame.size.width
        let label_size = frame_width*CGFloat(0.8/Float(length)) // UILabelはwidthの80%を占める
        let space_size = frame_width*CGFloat(0.2/Float(length+1))
        var x = space_size
        let uilabels = string.map({(spell) -> UILabel in
            let label = UILabel(frame: CGRect(x: x, y: view.frame.size.width*CGFloat(0.05), width: label_size, height: label_size))
            x += label_size + space_size
            // 角を丸くする
            label.layer.cornerRadius = label_size/2
            label.clipsToBounds = true
            // 枠線を表示
            label.layer.borderWidth = 0.08*label_size
            label.layer.borderColor = Color.gray.cgColor
            // 文字の位置のセンタリングやバックグラウンドの設定
            label.backgroundColor = .white
            label.textAlignment = .center
            label.text = String(spell)
            label.textColor = .gray
            // Times New Roman
            label.font = UIFont(name: "Menlo", size: 0.8*label_size)
            return label
        })
        return uilabels
    }
}
