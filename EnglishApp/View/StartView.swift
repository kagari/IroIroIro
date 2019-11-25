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
    private var image2: UIImage = UIImage(named: "hikari")!
    private var imageView1: UIImageView?
    private var imageView2: UIImageView?
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
        self.imageView1 = UIImageView(image: image1)
        self.imageView2 = UIImageView(image: image2)
        self.addSubview(self.imageView1!)
        self.addSubview(self.imageView2!)

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.repeat,.autoreverse],
                       animations: {
                        self.imageView2?.alpha = 0.0
        }, completion: nil)
    }
    
    // startボタン
    func makeStartButton() {
        self.startButton.setTitle("START", for: .normal) // タイトルを設定する
        self.startButton.setTitleColor(UIColor(red:120/255, green:204/255, blue:208/255, alpha:1), for: .normal)
        self.startButton.addTarget(self, action: #selector(buttonEvent(button:)), for: .touchUpInside)
        self.addSubview(self.startButton)
    }
    
    // 遊び方
    func makeHowToButton() {
        self.howToButton.setTitle("遊び方", for: UIControl.State())
        self.howToButton.setTitleColor(.white, for: UIControl.State())
        self.howToButton.backgroundColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1)
        self.howToButton.addTarget(self, action: #selector(goHowTo(button:)), for: .touchUpInside)
        self.addSubview(self.howToButton)
    }
    
    // 設定
    func makeSettingsButton() {
        self.settingButton.setTitle("設定", for: UIControl.State())
        self.settingButton.setTitleColor(.white, for: UIControl.State())
        self.settingButton.backgroundColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1)
        self.settingButton.addTarget(self, action: #selector(goSetting(button:)), for: .touchUpInside)
        self.addSubview(self.settingButton)
    }
    
    override func layoutSubviews() {
        let width = self.frame.width
        let height = self.frame.height
        let imgWidth1 = self.image1.size.width // 画像の縦横サイズを取得
        let imgHeight1 = self.image1.size.height

        let imgWidth2 = self.image2.size.width // 画像の縦横サイズを取得
        let imgHeight2 = self.image2.size.height
        
        let scale: CGFloat = width / imgWidth1 // 画像サイズをスクリーン幅に合わせる
        let rect: CGRect = CGRect(x: 0, y: 0, width: imgWidth1*scale - 100, height: imgHeight1*scale)
        let rect2: CGRect = CGRect(x: 0, y: 0, width: imgWidth2*scale + 100, height: imgHeight2*scale + 30)
        
        self.imageView1?.frame = rect  // ImageView frameをCGRectで作った矩形に合わせる
        self.imageView1?.center = CGPoint(x: width*0.5, y: 350) // 画像の中心を画面の中心に設定
        
        self.imageView2?.frame = rect2
        self.imageView2?.center = CGPoint(x: width*0.5, y: height*0.55)
        
        self.startButton.frame = CGRect(x: 0, y: height*0.38, width: width, height: height*0.3)
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: height < width*2 ? height*0.085 : width*0.16)
        
        self.howToButton.frame = CGRect(x: 0, y: height*0.8, width: width*0.5, height: height*0.2)
        self.howToButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.05)
        
        self.settingButton.frame = CGRect(x: width*0.5, y: height*0.8, width: width*0.5, height: height*0.2)
        self.settingButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.05)
    }
    
    // MARK: - ボタンタップ時の挙動
    @objc func buttonEvent(button: UIButton) {
        delegate?.buttonEvent(button)
    }
    
    @objc func goHowTo(button: UIButton) {
        delegate?.goHowTo(button)
    }
    
    @objc func goSetting(button: UIButton) {
        delegate?.goSetting(button)
    }
}



