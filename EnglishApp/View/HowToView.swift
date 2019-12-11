import UIKit
import AVFoundation

protocol HowToViewDelegate: class {
    func onbackClick(_:UIButton)
}

class HowToView: UIView {
    var delegate: HowToViewDelegate?
    private let image = UIImage(named:"howtoplay4")!
    private var imageView: UIImageView?
    private var backBtn: UIButton?
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    let asset = NSDataAsset(name:"howToPlay")
    let videoUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("howToPlay.mp4")

    
    override init(frame: CGRect) {
        
        self.playerLayer = AVPlayerLayer(player: self.player)
        
        try! asset!.data.write(to: self.videoUrl)
        
        let item = AVPlayerItem(url: self.videoUrl)
        self.player = AVPlayer(playerItem: item)
        
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.player.play()
            
        self.playerLayer.frame = self.bounds
        self.playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer.zPosition = -1 // ボタン等よりも後ろに表示
        self.layer.insertSublayer(self.playerLayer, at: 0) // 動画をレイヤーとして追加
        self.layer.addSublayer(self.playerLayer)
        
        //戻るボタン
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        let imgWidth = image.size.width
        let imgHeight = image.size.height
        let scale = width / imgWidth
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: imgWidth*scale, height: imgHeight*scale)
        self.backBtn?.frame = CGRect(x: width*0.7 , y: height*0.9, width: width*0.28, height: height*0.05)
        self.backBtn?.titleLabel?.font = UIFont.systemFont(ofSize: height*0.03)
    }
    
    @objc func onbackClick(button: UIButton) {
        delegate?.onbackClick(button)
    }
}
