import Foundation
import UIKit
import LTMorphingLabel

protocol ResultUsedTextViewDataSource: class {
    var usedTextString: [String]? { get }
}

class ResultUsedTextView: UIView {
    
    weak var dataSource: ResultUsedTextViewDataSource?
    var usedTextLabels: [UILabel]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "Result"
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 100)
            label.textAlignment = .center
            return label
        }()
        
        label.sizeToFit()
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // QuestionModelからお題のデータを受け取る関数
    func setUsedTextLabels() {
        print("setUsedTextLabel")
        guard let used_text = dataSource?.usedTextString else {
            print("dataSource?.usedTextString is nil.")
            return
        }
        initUsedTextLabels(used_text: used_text)
        
        for usedTextLabel in usedTextLabels {
            usedTextLabel.sizeToFit()
            self.addSubview(usedTextLabel)
        }
    }
    
    // 使用した英単語のLabelを作成する関数
        private func initUsedTextLabels(used_text: [String]) {
            self.usedTextLabels = {

                var i = 300

                let TextLabels = used_text.map({(text) -> UILabel in
                    let label = LTMorphingLabel()
                    label.morphingEffect = .pixelate
                    label.text = text
                    label.textColor = UIColor(rgb: 0xFF65B2)
                    label.font = UIFont(name: "Menlo", size: 50)
                    label.textAlignment = .center
                    
                    
                    for count in 0...used_text.count{
                        var total = used_text.count
                        total -= count
                        label.frame = CGRect(x: 0, y: i, width: Int(0.8*self.frame.width), height: Int(0.2*self.frame.height))
                        i += 10
                    }
                    return label
                })
                return TextLabels
            }()
        }
    }
