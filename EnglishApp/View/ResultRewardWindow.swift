import Foundation
import UIKit

class RewardWindow: UIView {
    var descriptionLabel: UILabel
    var rewardLabel: UILabel
    var okButton: UIButton
    
    init(reward: String?, frame: CGRect) {
        self.descriptionLabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont(name: "Menlo", size: 50)
            
            let text1 = "5つの英単語が作れたね！"
            let text2 = "ごほうびをもらいにいこう！！"
            let text = text1 + "\n" +  text2
            
            let textAttribute = NSMutableAttributedString(string: text)
            textAttribute.addAttributes([
                .font: UIFont.boldSystemFont(ofSize: 60)
            ], range: NSMakeRange(text1.count+1, text2.count))
            
            label.attributedText = textAttribute
            label.adjustsFontSizeToFitWidth = true
            label.textColor = UIColor(rgb: 0xFF65B2)

            return label
        }()
        
        
        self.rewardLabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "Menlo", size: 50)
            label.adjustsFontSizeToFitWidth = true
            
            label.text = reward
            return label
        }()
        
        self.okButton = {
            let button = UIButton()
            button.backgroundColor = UIColor(rgb: 0x78CCD0)
            button.setTitle("GET！", for: .init())
            button.setTitleColor(UIColor.white, for: .init())
            button.titleLabel?.font = UIFont(name: "Menlo", size: 50)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            return button
        }()
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.borderColor = UIColor(rgb: 0x78CCD0).cgColor
        
        self.okButton.addTarget(self, action: #selector(okButtonEvent(_:)), for: .touchUpInside)

        self.addSubview(self.descriptionLabel)
        self.addSubview(self.rewardLabel)
        self.addSubview(self.okButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        
        self.layer.borderWidth = width*0.01
        self.layer.cornerRadius = width*0.15
        
        self.descriptionLabel.frame = CGRect(x: 0, y: height*0.1, width: width*0.8, height: height*0.3)
        self.descriptionLabel.center.x = width*0.5
        
        self.rewardLabel.frame = CGRect(x: 0, y: height*0.4, width: width*0.8, height: height*0.4)
        self.rewardLabel.center.x = width*0.5

        self.okButton.frame = CGRect(x: 0, y: height*0.85, width: width*0.4, height: height*0.1)
        self.okButton.layer.cornerRadius = width*0.4*0.1
        self.okButton.center.x = width*0.5
    }
    
    @objc func okButtonEvent(_: UIButton) {
        self.removeFromSuperview()
    }
}
