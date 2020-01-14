import UIKit

protocol RewardViewDelegate: class {
    func goSave(reward: String?)
    func onbackClick(_:UIButton)
}
class RewardView: UIView, UITextFieldDelegate {
    
    var delegate: RewardViewDelegate?
    private var backBtn: UIButton? = UIButton()
    private var myTextField: UITextField!
    private var rewardLabel: UILabel!
    private var nowRewardtextLabel: UILabel!
    
    private var rewardBackground = UIImage(named: "rewardBackgrounds")!
    private var ImageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0xc7e8ff)
        self.makeTextField()
        self.makebackButton()
        self.ribbonImage()
        
        self.nowRewardtextLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0x000000)
            label.font = UIFont(name: "Menlo", size: 200)
            label.textAlignment = .center
            label.layer.cornerRadius = 15
            label.text = "保護者の方にわたしてね"
            return label
        }()
        self.addSubview(self.nowRewardtextLabel)
        
        self.rewardLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0x000000)
            label.font = UIFont(name: "Menlo", size: 200)
            label.textAlignment = .center
            label.layer.cornerRadius = 15
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        self.addSubview(self.rewardLabel)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
   //テキストフィールド
    func makeTextField() {
        // UITextFieldの配置するx,yと幅と高さを設定.
        self.myTextField = UITextField()
        self.myTextField.delegate = self
        self.myTextField.backgroundColor = .white
        // キーボードタイプを指定
        self.myTextField.keyboardType = .default
        //枠線のスタイル
        self.myTextField.layer.borderColor = UIColor(rgb: 0x78CCD0).cgColor
        self.myTextField.layer.borderWidth = 6.0
        self.myTextField.layer.cornerRadius = 10.0
        //文字サイズ
        self.myTextField.font = UIFont.systemFont(ofSize: 70)
        self.myTextField.textColor = .black
        // 改行ボタンの種類を設定
        self.myTextField.returnKeyType = .done
        // UITextFieldを追加
        self.addSubview(self.myTextField)
    }
        
    //戻るボタン
    func makebackButton() {
        self.backBtn = UIButton()
        self.backBtn?.setTitle("戻る", for: UIControl.State())
        self.backBtn?.setTitleColor(.white, for: UIControl.State())
        self.backBtn?.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.backBtn?.layer.cornerRadius = 10.0
        self.backBtn?.layer.borderColor = UIColor(rgb: 0x78CCD0).cgColor
        self.backBtn?.layer.borderWidth = 1.0
        self.backBtn?.addTarget(self, action: #selector(onbackClick(button:)), for: .touchUpInside)
        self.addSubview(self.backBtn!)
    }
    
    private func ribbonImage() {
         self.ImageView = UIImageView(image: self.rewardBackground)
         self.addSubview(self.ImageView!)
         self.sendSubviewToBack(self.ImageView)
     }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        
        self.nowRewardtextLabel.frame = CGRect(x: 0 , y: height*0.45, width: width*0.96, height: height*0.12)
        self.nowRewardtextLabel.center.x = self.center.x
        self.nowRewardtextLabel.font = UIFont.systemFont(ofSize: height*0.05)
    
        self.rewardLabel.frame = CGRect(x: width*0.02, y: height*0.25, width: width*0.96, height: height*0.1)
        self.rewardLabel.center.x = self.center.x
        
        self.myTextField.frame = CGRect(x: 0 , y: height*0.55, width: width*0.95, height: height*0.12)
        self.myTextField.center.x = self.center.x
            
        self.backBtn?.titleLabel?.font = UIFont.systemFont(ofSize: height*0.03)
        self.backBtn?.frame = CGRect(x: width*0.7 , y: height*0.9, width: width*0.28, height: height*0.05)
        
        self.ImageView?.frame =  self.frame

    }
    
    func setTextField(reward: String?) {
        self.myTextField.placeholder = "ご褒美を入力してください"
        self.myTextField.text = reward
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.myTextField.resignFirstResponder()
        self.goSave()
        return true
    }
    
    func setRewardLabel(reward: String?) {
        self.rewardLabel.text =  reward
    }
    
    @objc func goSave() {
        let reward = self.myTextField.text
        self.setRewardLabel(reward: reward)
        print("reward: \(String(describing: reward))")
        self.delegate?.goSave(reward: reward)
    }
    
    @objc func onbackClick(button: UIButton) {
        self.delegate?.onbackClick(button)
    }
}
