import Foundation
import UIKit

class PopUpView: UIView {
    
    var okButton: UIButton!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0xC0C0C0)
        
        self.okButton = {
            let button = UIButton()
            button.setTitle("OK", for: .init())
            button.setTitleColor(.white, for: UIControl.State())
            button.backgroundColor = UIColor(rgb: 0x78CCD0)
            button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
            return button
        }()
        
        self.titleLabel = {
            let label = UILabel()
            label.text = "保護者の方にわたしてね！"
            //label.backgroundColor = .white
            label.textColor = UIColor(rgb: 0x000000)
            label.textAlignment = .center
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
        
        self.okButton.frame = CGRect(x: 0, y: height*0.7, width: width*0.2, height: height*0.25)
        self.okButton.center.x = width*0.5
        self.okButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.2)
        
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: height*0.9)
        self.titleLabel.center.x = width*0.5
        self.titleLabel.font = UIFont.systemFont(ofSize: height*0.2)
        
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        print("tap ok button")
        self.removeFromSuperview()
     }
}
