//
//  RewardView.swift
//  EnglishApp
//
//  Created by 是澤真由 on 2019/11/20.
//

import UIKit

protocol RewardViewDelegate: class {
    func goSave(_:UIButton)
    func onbackClick(_:UIButton)
}
class RewardView: UIView {
    var delegate: RewardViewDelegate?
    private var backBtn: UIButton? = UIButton()
    private var saveButton: UIButton = UIButton()
    private var myTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.makeRewardButton()
        self.maketextaField()
        self.makebackButton()
       
    }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    
   //テキストフィールド
    func maketextaField() {
        // UITextFieldの配置するx,yと幅と高さを設定.
        let Width: CGFloat = 200
        let Height: CGFloat = 30
        
        let textField = UITextField()
        textField.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width-20, height: 38)
        // プレースホルダを設定
        textField.placeholder = "入力してください。"
        // キーボードタイプを指定
        textField.keyboardType = .default
        // 枠線のスタイルを設定
        textField.borderStyle = .roundedRect
        // 改行ボタンの種類を設定
        textField.returnKeyType = .done
        // テキストを全消去するボタンを表示
        textField.clearButtonMode = .always
        // UITextFieldを追加
        self.addSubview(textField)
        
    }

    func makeRewardButton() {
        self.saveButton.setTitle("保存", for: .normal) // タイトルを設定する
        self.saveButton.setTitleColor(UIColor(red:255/255, green:0/255, blue:0/255, alpha:1), for: .normal)
        self.saveButton.addTarget(self, action: #selector(goSave(button:)), for: .touchUpInside)
        self.addSubview(self.saveButton)
    }
    
    //戻るボタン
    func makebackButton() {
        self.backBtn = UIButton()
        self.backBtn?.setTitle("戻る", for: UIControl.State())
        self.backBtn?.setTitleColor(.orange, for: UIControl.State())
        self.backBtn?.backgroundColor = .white
        self.backBtn?.layer.cornerRadius = 10.0
        self.backBtn?.layer.borderColor = UIColor.orange.cgColor
        self.backBtn?.layer.borderWidth = 1.0
        self.backBtn?.addTarget(self, action: #selector(onbackClick(button:)), for: .touchUpInside)
        self.addSubview(self.backBtn!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
           
        self.saveButton.frame = CGRect(x: width*0.2, y: height*0.8, width: width*0.5, height: height*0.2)
        self.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.05)
        
        self.backBtn?.frame = CGRect(x: width*0.7 , y: height*0.9, width: width*0.28, height: height*0.05)
       }
    
    @objc func goSave(button: UIButton) {
        delegate?.goSave(button)
    }
    
    @objc func onbackClick(button: UIButton) {
        delegate?.onbackClick(button)
       }
}
