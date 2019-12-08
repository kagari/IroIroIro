import Foundation
import UIKit

class ResultRewardComponent: UIView {
    var stars: [Star]!
    
    init(getStarCount: Int, frame: CGRect) {
        super.init(frame: frame)
        
        let size = frame.width/5 // star size
        let yPoint = frame.height/2
        
        self.stars = (1...5).map { idx in
            var star: Star
            
            if idx <= getStarCount {
                star = Star(isColor: true, frame: CGRect(x: 0, y: 0, width: size, height: size))
            } else {
                star = Star(isColor: false, frame: CGRect(x: 0, y: 0, width: size, height: size))
            }
            
            star.center.x = size/2 * CGFloat(idx)
            if (idx < 3) {
                star.center.y = yPoint * (0.75 + CGFloat(3 - idx%3)/5)
            } else {
                star.center.y = yPoint * (0.75 + CGFloat(idx%3)/5)
            }
            return star
        }
        
        self.stars.forEach { star in
            self.addSubview(star)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func thisGetStar(index: Int) {
        self.stars.enumerated().forEach { idx, star in
            if idx == index {
                star.setAnimation()
            }
        }
    }
    
    func getedStars(count: Int) {
        self.stars.enumerated().forEach { idx, star in
            if idx < count {
                star.setAnimation()
            }
        }
    }
}

class Star: UIView {
    var starImageView: UIImageView!
    
    init(isColor: Bool, frame: CGRect) {
        super.init(frame: frame)
        
        if isColor {
            self.starImageView = UIImageView(image: UIImage(named: "star_icon"))
        } else {
            self.starImageView = UIImageView(image: UIImage(named: "star_icon_no_color"))
        }
        self.addSubview(self.starImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.starImageView.frame = self.frame
    }
    
    func setColor() {
        self.starImageView = UIImageView(image: UIImage(named: "star_icon.png"))
    }
    
    func setAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = 2.0
        animation.fromValue = 1.25
        animation.toValue = 1.0
        animation.mass = 1.0
        animation.initialVelocity = 30.0
        animation.damping = 3.0
        animation.stiffness = 120.0
        self.layer.add(animation, forKey: nil)
    }
}
