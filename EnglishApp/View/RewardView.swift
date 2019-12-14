import UIKit

protocol RewardViewDelegate: class {
    func goSave(reward: String?)
    func onbackClick(_:UIButton)
}
class RewardView: UIView {
    
    var delegate: RewardViewDelegate?
    private var backBtn: UIButton? = UIButton()
    private var saveButton: UIButton = UIButton()
    private var myTextField: UITextView!
    private var settingLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.makeRewardButton()
        self.makeTextField()
        self.makebackButton()
        
        self.settingLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 200)
            label.textAlignment = .center
            label.text = "ご褒美を入力してください"
            return label
        }()
        self.addSubview(self.settingLabel)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
    
   //テキストフィールド
    func makeTextField() {
        // UITextFieldの配置するx,yと幅と高さを設定.
        self.myTextField = UITextView()
        
        // キーボードタイプを指定
        self.myTextField.keyboardType = .default
        //枠線のスタイル
        self.myTextField.layer.borderColor = UIColor(rgb: 0x78CCD0).cgColor
        self.myTextField.layer.borderWidth = 6.0
        self.myTextField.layer.cornerRadius = 10.0
        //文字サイズ
        self.myTextField.font = UIFont.systemFont(ofSize: 80)
        self.myTextField.textColor = UIColor(rgb: 0x78CCD0)
        // 改行ボタンの種類を設定
        self.myTextField.returnKeyType = .done

        // UITextFieldを追加
        self.addSubview(self.myTextField)
    }
    func makeRewardButton() {
        self.saveButton.setTitle("保存", for: .normal) // タイトルを設定する
        self.saveButton.setTitleColor(.white, for: UIControl.State())
        self.saveButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.saveButton.layer.cornerRadius = 4.0
        self.saveButton.layer.borderColor = UIColor(rgb: 0x78CCD0).cgColor
        self.saveButton.layer.borderWidth = 1.0
        self.saveButton.addTarget(self, action: #selector(goSave(button:)), for: .touchUpInside)
        self.addSubview(self.saveButton)
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
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        
        self.settingLabel.frame = CGRect(x: 0 , y: height*0.05, width: width*0.96, height: height*0.12)
        self.settingLabel.center.x = self.center.x
        self.settingLabel.font = UIFont.systemFont(ofSize: height*0.05)
        
        self.myTextField.frame = CGRect(x: width*0.02, y: height*0.2, width: width*0.96, height: height*0.55)
        
        self.saveButton.frame = CGRect(x: 0, y: height*0.8, width: width*0.2, height: height*0.1)
        self.saveButton.center.x = self.center.x
        self.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.05)
        
        self.backBtn?.titleLabel?.font = UIFont.systemFont(ofSize: height*0.03)
        self.backBtn?.frame = CGRect(x: width*0.7 , y: height*0.9, width: width*0.28, height: height*0.05)
    }
    
    func setTextField(reward: String?) {
        self.myTextField.text = reward
    }
    
    @objc func goSave(button: UIButton) {
        let reward = self.myTextField.text
        print("reward: \(String(describing: reward))")
        delegate?.goSave(reward: reward)
    }
    
    @objc func onbackClick(button: UIButton) {
        delegate?.onbackClick(button)
    }
}
