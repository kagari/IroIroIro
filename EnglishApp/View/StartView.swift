import Foundation
import UIKit

protocol StartViewDelegate: class {
    func didTapStartButton()
}

class StartView: UIView {
    
    // StartViewDelegateのインスタンスを宣言
    var delegate: StartViewDelegate?
    var titleLabel: UILabel!
    var startButton: UIButton!
    
    // 初期化関数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startButton = self.makeStartButton(fontsize: 100)
        titleLabel = {
            let label = UILabel()
            label.text = "いぇいご！！"
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 100)
            label.textAlignment = .center
            return label
        }()
        
        self.addSubview(titleLabel)
        self.addSubview(startButton)
        self.backgroundColor = .white
    }
    
    // ここは上のinit関数と全く同じことを書けばOK
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 多分レイアウトが変更されたときに呼び出される
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0.2*self.frame.height)
        startButton.frame = CGRect(x: 0, y: 0, width: 0.8*self.frame.width, height: 200)
        startButton.layer.position.x = self.center.x
        startButton.layer.position.y = 0.8*self.frame.height
    }
    
    
    // MARK: - UIボタンを作成する関数
    private func makeStartButton(fontsize: CGFloat) -> UIButton {
        let button: UIButton = {
            let button = UIButton()
            button.setTitle("Start", for: .normal) // タイトルを設定する
            button.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal) // 文字色の設定
            button.backgroundColor = UIColor(rgb: 0xFF65B2) // 背景色の設定
            button.layer.cornerRadius = 10 // 角の丸み
            button.layer.borderWidth = 5 // 枠線の太さ
            button.layer.borderColor = UIColor(rgb: 0xFF007F).cgColor // 枠線色の設定
            button.layer.shadowOpacity = 0.5 // 影の濃さを決める
            button.layer.shadowOffset = CGSize(width: 2, height: 2) // 影のサイズを決める

            let label = button.titleLabel! // タイトルテキストの参照
            label.textAlignment = .center // センタリングする
            label.font = UIFont.systemFont(ofSize: fontsize) // フォントサイズを決める
            
            // ボタンを押した時に実行するメソッドを指定
            button.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
            
            return button
        }()
        
        return button
    }
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func buttonEvent(_ sender: UIButton) {
        // delegateメソッドを読んで、後の処理（画面遷移）はApplicationControllerに任せる
        self.delegate?.didTapStartButton()
    }
}
