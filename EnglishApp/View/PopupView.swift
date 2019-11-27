import Foundation
import UIKit

class PopUpView: UIView {
    
    var okButton: UIButton!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x000000)
        
        self.okButton = {
            let button = UIButton()
            button.setTitle("Ok", for: .init())
            return button
        }()
        
        self.titleLabel = {
            let label = UILabel()
            label.text = "保護者の方に渡してね！"
            label.textColor = UIColor(rgb: 0x000000)
            return label
        }()
        
        self.addSubview(self.okButton)
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let height = self.frame.height
        let width = self.frame.width
        
        self.okButton.frame = CGRect(x: 0, y: height*0.8, width: width*0.1, height: height*0.05)
        self.okButton.center.x = self.center.x
        
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: height*0.9)
        self.titleLabel.center.x = self.center.x
    }
}
