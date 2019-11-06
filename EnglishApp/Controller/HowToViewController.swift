//
//  HowToViewController.swift
//  EnglishApp
//
//  Created by 新垣結梨 on 2019/11/04.
//

import Foundation
import UIKit


class HowToViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth:CGFloat = view.frame.size.width
        
        //遊び方ラベル
        let  eventLabel = UILabel(frame: CGRect(x: 290 , y: 100, width: 500, height: 100))
        eventLabel.text = "遊び方"
        eventLabel.textColor = .red
        eventLabel.font = UIFont.systemFont(ofSize: 80)
        view.addSubview(eventLabel)
        
        //遊び方説明ラベル
        let  eventLabel2 = UILabel(frame: CGRect(x: 50, y: 200, width: screenWidth, height: 200))
        eventLabel2.text = "1.你好 2.他是我的朋友 3.我想喝珍珠奶茶"
        
        eventLabel2.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(eventLabel2)
        
        
        
        
        //戻るボタン
        let backBtn = UIButton(frame: CGRect(x: w - 300 , y: h - 100, width: 200, height: 30))
        backBtn.setTitle("戻る", for: UIControl.State())
        backBtn.setTitleColor(.orange, for: UIControl.State())
        backBtn.backgroundColor = .white
        backBtn.layer.cornerRadius = 10.0
        backBtn.layer.borderColor = UIColor.orange.cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        view.addSubview(backBtn)
        
        
    }
    
    
    @objc func onbackClick(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
