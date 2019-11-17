import Foundation
import UIKit

class ResultView: UIView {
    
    var usedTextLabels: [UILabel]!
    var questionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.questionLabel.sizeToFit()
        super.layoutSubviews()
    }
    
    func setQuestionLabel(question: String?) {
        self.questionLabel = {
            let label = UILabel()
            label.text = question
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 100)
            label.textAlignment = .center
            return label
        }()
        
        self.addSubview(self.questionLabel)
    }
    
    // QuestionModelからお題のデータを受け取る関数
    func setUsedTextLabels(usedTexts: [String]?) {
        print("setUsedTextLabel")
        guard let used_texts = usedTexts else {
            print("usedTexts is nil.")
            return
        }
        self.initUsedTextLabels(used_texts: used_texts)
        
        for usedTextLabel in self.usedTextLabels {
            usedTextLabel.sizeToFit()
            self.addSubview(usedTextLabel)
        }
    }
    
    // 使用した英単語のLabelを作成する関数
    private func initUsedTextLabels(used_texts: [String]) {
        self.usedTextLabels = {

            var i = 200

            let TextLabels = used_texts.map({(text) -> UILabel in
                let label = UILabel()
                label.text = text
                label.textColor = UIColor(rgb: 0xFF65B2)
                label.font = UIFont(name: "Menlo", size: 50)
                label.textAlignment = .center
                
                
                for count in 0...used_texts.count{
                    var total = used_texts.count
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