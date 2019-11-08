import UIKit

let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

class StartView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.initImageView()
        self.makeStartButton()
        self.makeHowToButton()
        self.makeSettingsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initImageView() { //いぇいごを画像で表示
        let image1: UIImage = UIImage(named: "eigo")!  // UIImage インスタンスの生成
        let image2: UIImage = UIImage(named: "hikari")!
        
        let imageView = UIImageView(image: image1)  // UIImageView 初期化
        let imageView2 = UIImageView(image: image2)
        
        let screenWidth: CGFloat = w   // スクリーンの縦横サイズを取得
        //let screenHeight:CGFloat = view.frame.size.height
        
        let imgWidth: CGFloat = image1.size.width // 画像の縦横サイズを取得
        let imgHeight: CGFloat = image1.size.height
        
        let imgWidth2: CGFloat = image2.size.width // 画像の縦横サイズを取得
        let imgHeight2: CGFloat = image2.size.height
        
        
        let scale: CGFloat = screenWidth / imgWidth // 画像サイズをスクリーン幅に合わせる
        let rect: CGRect = CGRect(x: 0, y: 0, width: imgWidth*scale - 100, height: imgHeight*scale)
        let rect2: CGRect = CGRect(x: 0, y: 0, width: imgWidth2*scale + 100, height: imgHeight2*scale + 30)
        
        imageView.frame = rect  // ImageView frameをCGRectで作った矩形に合わせる
        imageView.center = CGPoint(x:screenWidth/2, y:350) // 画像の中心を画面の中心に設定
        self.addSubview(imageView) // UIImageViewのインスタンスをビューに追加
        
        imageView2.frame = rect2
        imageView2.center = CGPoint(x:screenWidth/2, y:605)
        self.addSubview(imageView2)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.repeat,.autoreverse],
                       animations: {
                        imageView2.alpha = 0.0
        }, completion: nil)
    }
    
    // startボタン
    func makeStartButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: w - 10, height: h + 60))
        button.setTitle("START", for: .normal) // タイトルを設定する
        button.setTitleColor(UIColor(red:120/255, green:204/255, blue:208/255, alpha:1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        button.addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)
        self.addSubview(button)
    }
    // 遊び方
    func makeHowToButton() {
        let howToButton = UIButton(frame: CGRect(x: 0, y: h - 200, width: w/2, height: 200))
        howToButton.setTitle("遊び方", for: UIControl.State())
        howToButton.setTitleColor(.white, for: UIControl.State())
        howToButton.backgroundColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1)
        howToButton.titleLabel?.font = UIFont.systemFont(ofSize: 80)
        howToButton.addTarget(self, action: #selector(goHowTo(_:)), for: .touchUpInside)
        self.addSubview(howToButton)
    }
    
    // 設定
    func makeSettingsButton() {
        let settingButton = UIButton(frame: CGRect(x: w/2, y: h - 200, width: w/2, height: 200))
        settingButton.setTitle("設定", for: UIControl.State())
        settingButton.setTitleColor(.white, for: UIControl.State())
        settingButton.backgroundColor = UIColor(red:120/255, green:204/255, blue:208/255, alpha:1)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 80)
        settingButton.addTarget(self, action: #selector(goSetting(_:)), for: .touchUpInside)
        self.addSubview(settingButton)
    }
    
    // MARK: - ボタンタップ時の挙動
    @objc func buttonEvent(_: UIButton) {
        print("Startボタンが押された!!")
    }
    
    @objc func goHowTo(_: UIButton) {
        print("説明ボタンが押された!!")
    }
    
    @objc func goSetting(_: UIButton) {
        print("設定ボタンが押された!!")
    }
}



