import Foundation
import UIKit

// https://e-joint.jp/544/
// https://dev.classmethod.jp/smartphone/utilty-extension-uicolor/
// ↑ を参照

enum Color: Int {
    case red = 0xC85D5D
    case orange = 0xDD7C3A
    case yellow = 0xD8C05B
    case green = 0x66A040
    case emerald = 0x5BAA84
    case lightblue = 0x63BFC1
    case blue = 0x4A78A5
    case purple = 0x835C91
    case pink = 0xD182B9
    case brown = 0x8E6C4D
    case gray = 0x828282
    case black = 0x3F3F3F
    
    var UIColor: UIKit.UIColor {
        return UIKit.UIColor(rgb: self.rawValue)
    }
    
    var cgColor: UIKit.CGColor {
        return self.UIColor.cgColor
    }
}

// HEXからUIColorに変換する拡張
extension UIColor {
     
    convenience init(rgb: Int) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgb & 0x0000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
     
    convenience init(rgba: Int) {
        let r: CGFloat = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((rgba & 0x0000FF00) >>  8) / 255.0
        let a: CGFloat = CGFloat( rgba & 0x000000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
