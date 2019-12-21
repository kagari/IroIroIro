import UIKit

let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

protocol StartViewDelegate: class {
    func buttonEvent(_:UIButton)
    func goHowTo(_:UIButton)
    func goSetting(_:UIButton)
}

class StartView: UIView {
    
    var delegate: StartViewDelegate?
    
    private var image1: UIImage = UIImage(named: "eigo")!
    private var backgroundImage = UIImage(named: "HomeBackgrounds")!
    private var settingImage = UIImage(named: "setting")!
    private var imageView1: UIImageView?
    private var backgroundImageView: UIImageView?
    private var startButton: UIButton = UIButton()
    private var howToButton: UIButton = UIButton()
    private var settingButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.makeImage()
        self.makeStartButton()
        self.makeHowToButton()
        self.makeSettingsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeImage() {
        self.backgroundImageView = UIImageView(image: self.backgroundImage)
        self.addSubview(self.backgroundImageView!)

        self.imageView1 = UIImageView(image: image1)
        self.addSubview(self.imageView1!)
    }
    
    // startボタン
    func makeStartButton() {
        self.startButton.setTitle("START", for: .normal) // タイトルを設定する
        self.startButton.titleLabel?.numberOfLines = 1
        self.startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.startButton.titleLabel?.font = UIFont(name: "Menlo", size: 100)
        self.startButton.backgroundColor = UIColor(rgb: 0xFF65B2)
        self.startButton.addTarget(self, action: #selector(buttonEvent(button:)), for: .touchUpInside)
        self.addSubview(self.startButton)
    }
    
    // 遊び方
    func makeHowToButton() {
        self.howToButton.setTitle("遊び方を見る", for: UIControl.State())
        self.howToButton.titleLabel?.textAlignment = .center
        self.howToButton.titleLabel?.numberOfLines = 1
        self.howToButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.howToButton.titleLabel?.font = UIFont(name: "Menlo", size: 40)
        self.howToButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.howToButton.addTarget(self, action: #selector(goHowTo(button:)), for: .touchUpInside)
        self.addSubview(self.howToButton)
    }
    
    // 設定
    func makeSettingsButton() {
        self.settingButton.setImage(self.settingImage, for: .init())
        self.settingButton.imageView?.contentMode = .scaleToFill
        self.settingButton.contentHorizontalAlignment = .fill
        self.settingButton.contentVerticalAlignment = .fill
         
        self.settingButton.backgroundColor = UIColor(rgb: 0xFF65B2)
        self.settingButton.addTarget(self, action: #selector(goSetting(button:)), for: .touchUpInside)
        self.startButton.addTarget(self, action: #selector(didTouchDownButton(_:)), for: .touchDown)
        self.startButton.addTarget(self, action: #selector(didTouchDragExitButton(_:)), for: .touchDragExit)
        self.addSubview(self.settingButton)
    }
    
    override func layoutSubviews() {
        let width = self.frame.width
        let height = self.frame.height
            
        self.backgroundImageView?.frame = self.frame

        let imgWidth1 = self.image1.size.width
        let imgHeight1 = self.image1.size.height
        let scale: CGFloat = width/imgWidth1*0.73
        self.imageView1?.frame = CGRect(x: 0, y: 0, width: imgWidth1*scale, height: imgHeight1*scale)
        self.imageView1?.center = CGPoint(x: width*0.5, y: height*0.45) // 画像の中心を画面の中心に設定
        
        self.startButton.frame = CGRect(x: 0, y: 0, width: width*0.45, height: height*0.098)
        self.startButton.layer.cornerRadius = width*0.02
        self.startButton.center = CGPoint(x: width*0.5, y: height*0.6)
        
        self.howToButton.frame = CGRect(x: 0, y: 0, width: width*0.4, height: height*0.08)
        self.howToButton.layer.cornerRadius = width*0.02
        self.howToButton.center = CGPoint(x: width*0.5, y: height*0.92)

        let buttonSize = width*0.11
        self.settingButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        self.settingButton.center = CGPoint(x: width*0.1, y: height*0.08)
        self.settingButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.settingButton.layer.cornerRadius = buttonSize*0.5
    }
    
    @objc func didTouchDownButton(_: UIButton) {
        // ボタンを縮こませます
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.startButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }

    @objc func didTouchDragExitButton(_: UIButton) {
        // 縮こまったボタンをアニメーションで元のサイズに戻します
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.startButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    // MARK: - ボタンタップ時の挙動
    @objc func buttonEvent(button: UIButton) {
        UIView.animate(withDuration: 0.5,
        delay: 0.0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 8,
        options: .curveEaseOut,
        animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            self.delegate?.buttonEvent(button)
        })
    }
    
    @objc func goHowTo(button: UIButton) {
        self.delegate?.goHowTo(button)
    }
    
    @objc func goSetting(button: UIButton) {
        self.delegate?.goSetting(button)
    }
}



