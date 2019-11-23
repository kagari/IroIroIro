import Foundation
import UIKit

// MARK: - お題を表示するためのUILabelのリストを作成する関数
func makeBaseUILabels(string: String?, index: Int) -> [UILabel]? {
    let uilabels = string?.enumerated().map({(idx, spell) -> UILabel in
        let label = UILabel()
        label.clipsToBounds = true
        // 文字の位置のセンタリングやバックグラウンドの設定
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = String(spell)
        if idx == index {
            label.layer.borderColor = UIColor(rgb: 0xFF65B2).cgColor
            label.textColor = UIColor(rgb: 0xFF65B2)
        } else {
            label.layer.borderColor = UIColor(rgb: 0xedbebe).cgColor
            label.textColor = UIColor(rgb: 0xbeeded)
        }
        label.tag = 0
        return label
    })
    return uilabels
}

func setUILabelSize(uilabels: [UILabel]?, x: CGFloat, y: CGFloat, width: CGFloat) -> [UILabel]? {
    guard let length = uilabels?.count else {
        fatalError("uilabel is nil...")
    }
    
    let label_size = width * CGFloat(0.8/Float(length)) // UILabelはwidthの80%を占める
    let space_size = width * CGFloat(0.2/Float(length+1))
    var _x = x + space_size
    
    return uilabels?.map { label -> UILabel in
        label.frame = CGRect(x: _x, y: y, width: label_size, height: label_size)
        // 角を丸くする
        label.layer.cornerRadius = label_size/2
        // 枠線を表示
        label.layer.borderWidth = 0.08*label_size
        // フォントとサイズを決定
        label.font = UIFont(name: "Menlo", size: 0.8*label_size)
        
        // x positionを更新
        _x += label_size + space_size
        return label
    }
}

// MARK: - UsedTextLabel用
func makeUILabelsForUsedTextLabel(string: String?, index:Int, x: CGFloat, y: CGFloat, labelSize: CGFloat) -> [UILabel]? {
    
    var x = x
    let uilabels = string?.enumerated().map({(idx,spell) -> UILabel in
        let label = UILabel(frame: CGRect(x: x, y: y, width: labelSize, height: labelSize))
        x += labelSize
        // 文字の位置のセンタリングやバックグラウンドの設定
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = String(spell)
        
        if idx == index{
            // 角を丸くする
            label.layer.cornerRadius = labelSize/2
            label.clipsToBounds = true
            // 枠線を表示
            label.layer.borderWidth = 0.08*labelSize
            label.layer.borderColor = UIColor(rgb: 0xed0000).cgColor
            label.textColor = UIColor(rgb: 0xFF80BF)
        } else {
            // 角を丸くする
            label.layer.cornerRadius = labelSize/2
            label.clipsToBounds = true
            label.textColor = UIColor(rgb: 0xFF80BF)
        }

        label.font = UIFont(name: "Menlo", size: 0.8*labelSize)
        return label
    })
    return uilabels
}
