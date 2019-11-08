//
//  HowToController.swift
//  Sample
//
//  Created by 新垣結梨 on 2019/10/31.
//  Copyright © 2019 Yuiri A. All rights reserved.
//

import Foundation
import UIKit


class HowToController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initImageView2()
        
//        //遊び方ラベル
//        let  eventLabel = UILabel(frame: CGRect(x: 290 , y: 100, width: 500, height: 100))
//        eventLabel.text = "遊び方"
//        eventLabel.textColor = .red
//        eventLabel.font = UIFont.systemFont(ofSize: 80)
//        view.addSubview(eventLabel)
//
//        //遊び方説明ラベル
//        let  eventLabel2 = UITextView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 0.2*view.frame.height))
//        eventLabel2.text = "1.お題の文字を探そう！！ \n2.見つけたら你好！！ "
//        eventLabel2.font = UIFont.systemFont(ofSize: 50)
//        eventLabel2.layer.borderColor = UIColor.blue.cgColor
//        eventLabel2.layer.borderWidth = 5.0
//        view.addSubview(eventLabel2)
//
//
//        eventLabel2.isEditable = false
//
    
        
        //戻るボタン
        let backBtn = UIButton(frame: CGRect(x: w - 300 , y: h - 85, width: 200, height: 30))
        backBtn.setTitle("戻る", for: UIControl.State())
        backBtn.setTitleColor(.orange, for: UIControl.State())
        backBtn.backgroundColor = .white
        backBtn.layer.cornerRadius = 10.0
        backBtn.layer.borderColor = UIColor.orange.cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        view.addSubview(backBtn)
        
    }
    
    private func initImageView2(){ //遊び方を画像で表示
            let image3:UIImage = UIImage(named:"howtoplay3")!  // UIImage インスタンスの生成
            
            let imageView3 = UIImageView(image:image3)  // UIImageView 初期化
          
            
            let screenWidth:CGFloat = view.frame.size.width   // スクリーンの縦横サイズを取得
            
            let imgWidth3:CGFloat = image3.size.width // 画像の縦横サイズを取得
            let imgHeight3:CGFloat = image3.size.height
            
            
            
            let scale:CGFloat = screenWidth / imgWidth3 // 画像サイズをスクリーン幅に合わせる
            let rect:CGRect = CGRect(x:0, y:0, width:imgWidth3*scale, height:imgHeight3*scale)
    
            
            imageView3.frame = rect;  // ImageView frameをCGRectで作った矩形に合わせる
            //imageView3.center = CGPoint(x:screenWidth/2, y:350) // 画像の中心を画面の中心に設定
            self.view.addSubview(imageView3) // UIImageViewのインスタンスをビューに追加

            
        }
    
    @objc func onbackClick(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
