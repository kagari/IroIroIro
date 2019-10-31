import Foundation
import UIKit

class StartView: UIView {
    
    var startButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startButton = self.makeStartButton(fontsize: 100)
        
        self.addSubview(startButton)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        startButton = self.makeStartButton(fontsize: 100)
        
        self.addSubview(startButton)
        self.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        startButton.frame = CGRect(x: 0, y: 0, width: 0.8*self.frame.width, height: 200)
        startButton.layer.position = self.center
    }
    
    private func makeStartButton(fontsize: CGFloat) -> UIButton {
        let button: UIButton = {
            let button = UIButton()
            button.setTitle("Start", for: .normal) // タイトルを設定する
            button.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal) // 文字色の設定
            button.backgroundColor = UIColor(rgb: 0xFF65B2) // 背景色の設定
            button.layer.cornerRadius = 10 // 角の丸み
            button.layer.borderWidth = 5 // 枠線の太さ
            button.layer.borderColor = UIColor(rgb: 0xFF007F).cgColor // 枠線色の設定

            let label = button.titleLabel! // タイトルテキストの参照
            label.textAlignment = .center // センタリングする
            label.font = UIFont.systemFont(ofSize: fontsize) // フォントサイズを決める
            return button
        }()
        
        return button
    }
}
