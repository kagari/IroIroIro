
import Foundation
import UIKit

// MARK: - お題を表示するためのUILabelのリストを作成する関数
func make_label(string: String?, index:Int, view: UIView) -> [UILabel]? {
    
    guard let length = string?.lengthOfBytes(using: String.Encoding.utf8) else {
        fatalError("stringに文字列が入っていない")
    }
    let frame_width = view.frame.size.width
    let label_size = frame_width*CGFloat(0.8/Float(length)) // UILabelはwidthの80%を占める
    let space_size = frame_width*CGFloat(0.2/Float(length+1))
    var x = space_size
    let uilabels = string?.enumerated().map({(idx,spell) -> UILabel in
        let label = UILabel(frame: CGRect(x: x, y: view.frame.size.height*CGFloat(0.05), width: label_size, height: label_size))
        x += label_size + space_size
        // 角を丸くする
        label.layer.cornerRadius = label_size/2
        label.clipsToBounds = true
        // 枠線を表示
        label.layer.borderWidth = 0.08*label_size
        
        // 文字の位置のセンタリングやバックグラウンドの設定
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = String(spell)
        
        if idx == index{
            label.layer.borderColor = UIColor(rgb: 0xed0000).cgColor
            label.textColor = UIColor(rgb: 0x00eded)
        } else {
            label.layer.borderColor = UIColor(rgb: 0xedbebe).cgColor
            label.textColor = UIColor(rgb: 0xbeeded)
        }

        label.font = UIFont(name: "Menlo", size: 0.8*label_size)
        return label
    })
    return uilabels
}

// MARK: - result画面で使用した単語を表示するためのUILabelのリストを作成する関数
func result_label(string: String?, index:Int, view: UIView) -> [UILabel]? {
    
    guard let length = string?.lengthOfBytes(using: String.Encoding.utf8) else {
        fatalError("stringに文字列が入っていない")
    }
    let frame_width = view.frame.size.width
    let label_size = frame_width*CGFloat(0.8/Float(length)) // UILabelはwidthの80%を占める
    let space_size = frame_width*CGFloat(0.2/Float(length+1))
    var x = space_size
    let uilabels = string?.enumerated().map({(idx,spell) -> UILabel in
        let label = UILabel(frame: CGRect(x: x, y: view.frame.size.height*CGFloat(0.05), width: label_size, height: label_size))
        x += label_size + space_size
        // 角を丸くする
        label.layer.cornerRadius = label_size/2
        label.clipsToBounds = true
        // 枠線を表示
        label.layer.borderWidth = 0.08*label_size
        
        // 文字の位置のセンタリングやバックグラウンドの設定
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = String(spell)
        
        if idx == index{
            label.layer.borderColor = UIColor(rgb: 0xed0000).cgColor
            label.textColor = UIColor(rgb: 0x00eded)
        } else {
            label.layer.borderColor = UIColor(rgb: 0xedbebe).cgColor
            label.textColor = UIColor(rgb: 0xbeeded)
        }

        label.font = UIFont(name: "Menlo", size: 0.8*label_size)
        return label
    })
    return uilabels
}
