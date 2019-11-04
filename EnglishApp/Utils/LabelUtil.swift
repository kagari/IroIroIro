import Foundation
import UIKit

// MARK: - お題を表示するためのUILabelのリストを作成する関数
func make_label(string: String, view: UIView) -> [UILabel] {
    let length = string.lengthOfBytes(using: String.Encoding.utf8)
    let frame_width = view.frame.size.width
    let label_size = frame_width*CGFloat(0.8/Float(length)) // UILabelはwidthの80%を占める
    let space_size = frame_width*CGFloat(0.2/Float(length+1))
    var x = space_size
    let uilabels = string.map({(spell) -> UILabel in
        let label = UILabel(frame: CGRect(x: x, y: view.frame.size.height*CGFloat(0.05), width: label_size, height: label_size))
        x += label_size + space_size
        // 角を丸くする
        label.layer.cornerRadius = label_size/2
        label.clipsToBounds = true
        // 枠線を表示
        label.layer.borderWidth = 0.08*label_size
        label.layer.borderColor = Color.gray.cgColor
        // 文字の位置のセンタリングやバックグラウンドの設定
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = String(spell)
        label.textColor = Color.gray.UIColor
        label.font = UIFont(name: "Menlo", size: 0.8*label_size)
        return label
    })
    return uilabels
}
