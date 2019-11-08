//
//  ViewController.swift
//  Sample
//
//  Created by 新垣結梨 on 2019/10/31.
//  Copyright © 2019 Yuiri A. All rights reserved.
//

import UIKit

let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initImageView()
        self.makeStartButton()
        self.makeHowToButton()
        self.makeSettingsButton()
        
    }

    
    private func initImageView(){ //いぇいごを画像で表示
        let image1:UIImage = UIImage(named:"eigo")!  // UIImage インスタンスの生成
        let image2:UIImage = UIImage(named:"hikari")!
        
        let imageView = UIImageView(image:image1)  // UIImageView 初期化
        let imageView2 = UIImageView(image:image2)
        
        let screenWidth:CGFloat = view.frame.size.width   // スクリーンの縦横サイズを取得
        //let screenHeight:CGFloat = view.frame.size.height
        
        let imgWidth:CGFloat = image1.size.width // 画像の縦横サイズを取得
        let imgHeight:CGFloat = image1.size.height
        
        let imgWidth2:CGFloat = image2.size.width // 画像の縦横サイズを取得
        let imgHeight2:CGFloat = image2.size.height
        
        
        let scale:CGFloat = screenWidth / imgWidth // 画像サイズをスクリーン幅に合わせる
        let rect:CGRect = CGRect(x:0, y:0, width:imgWidth*scale - 100, height:imgHeight*scale)
        let rect2:CGRect = CGRect(x:0, y:0, width:imgWidth2*scale + 100, height:imgHeight2*scale + 30)
        
        imageView.frame = rect;  // ImageView frameをCGRectで作った矩形に合わせる
        imageView.center = CGPoint(x:screenWidth/2, y:350) // 画像の中心を画面の中心に設定
        self.view.addSubview(imageView) // UIImageViewのインスタンスをビューに追加
        
        imageView2.frame = rect2;
        imageView2.center = CGPoint(x:screenWidth/2, y:605)
        self.view.addSubview(imageView2)
        
        
        UIView.animate(withDuration: 0.5,
                   delay: 0.0,
                   options: [.repeat,.autoreverse],
                   animations: {
                                imageView2.alpha = 0.0
        }, completion: nil)
        
        
    }
    
    private func makeStartButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: w - 10, height: h + 60))
            button.setTitle("START", for: .normal) // タイトルを設定する
            button.setTitleColor(UIColor(red:120/255, green:204/255, blue:208/255, alpha:1), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 100)
            button.addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)
            view.addSubview(button)
    }
    //遊び方
    private func makeHowToButton(){
        let howToButton = UIButton(frame: CGRect(x: 0, y: h - 200, width: w/2, height: 200))
            howToButton.setTitle("遊び方", for: UIControl.State())
            howToButton.setTitleColor(.white, for: UIControl.State())
            howToButton.backgroundColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1)
            howToButton.titleLabel?.font = UIFont.systemFont(ofSize: 80)
            howToButton.addTarget(self, action: #selector(goHowTo(_:)), for: .touchUpInside)
            view.addSubview(howToButton)
    }
    
    //設定
    private func makeSettingsButton(){
        let settingButton = UIButton(frame: CGRect(x: w/2, y: h - 200, width: w/2, height: 200))
        settingButton.setTitle("設定", for: UIControl.State())
        settingButton.setTitleColor(.white, for: UIControl.State())
        settingButton.backgroundColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 80)
        settingButton.addTarget(self, action: #selector(goSetting(_:)), for: .touchUpInside)
        view.addSubview(settingButton)
        
    }
    
    // MARK: - UIを整える関数
    @objc func buttonEvent(_ sender: UIButton) {
        let questionViewController = QuestionViewController()
        questionViewController.modalPresentationStyle = .fullScreen
        self.present(questionViewController, animated: true, completion: nil)
    }

    @objc func goHowTo(_: UIButton) {
        let gonext = HowToController()
        gonext.view.backgroundColor = UIColor.white
        gonext.modalPresentationStyle = .fullScreen
        self.present(gonext, animated: true, completion: nil)
    }
    
    @objc func goSetting(_: UIButton) {
        let gonext2 = SettingController()
        gonext2.view.backgroundColor = UIColor.white
        gonext2.modalPresentationStyle = .fullScreen
        self.present(gonext2, animated: true, completion: nil)
       }
        
}



