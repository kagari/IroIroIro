import UIKit
import AVFoundation

protocol HowToViewDelegate: class {
    func onbackClick(_:UIButton)
}

class HowToPlayVideoView: UIView {
    private var player: AVPlayer
    private var playerLayer: AVPlayerLayer
    private var cancelButton: UIButton
    
    override init(frame: CGRect) {
        let asset = NSDataAsset(name:"howToPlay")
        let videoUrl = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("movie.mp4")
        try? asset!.data.write(to: videoUrl)
        
        self.player = AVPlayer(url: videoUrl)
        self.playerLayer = AVPlayerLayer(player: self.player)
        
        self.cancelButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "cancel"), for: .init())
            button.imageView?.contentMode = .scaleToFill
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            
            button.backgroundColor = UIColor(rgb: 0x78CCD0)
            return button
        }()
        
        super.init(frame: frame)

        self.layer.addSublayer(self.playerLayer)
        
        self.cancelButton.addTarget(self, action: #selector(self.cancel(_:)), for: .touchUpInside)
        self.addSubview(self.cancelButton)

        NotificationCenter.default.addObserver(self,
                         selector: #selector(playerDidFinishPlaying),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height

        self.playerLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.playerLayer.videoGravity = .resizeAspect
        
        let buttonSize = width*0.15
        self.cancelButton.frame = CGRect(x: -buttonSize*0.15, y: -buttonSize*0.15, width: buttonSize, height: buttonSize)
        self.cancelButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.cancelButton.layer.cornerRadius = buttonSize*0.5
    }
    
    @objc private func playerDidFinishPlaying() {
        print("Finished!!")
        self.removeFromSuperview()
    }

    @objc func cancel(_ button: UIButton) {
        print("Pushed Cancel Button!")
        self.player.pause()
        self.removeFromSuperview()
    }

    func startVideo() {
        self.player.play()
    }
}
