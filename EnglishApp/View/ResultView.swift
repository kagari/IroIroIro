import Foundation
import UIKit

class ResultView: UIView {
    
    var usedTextLabels: [[UILabel]?]!
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
    func setUsedTextLabels(usedTexts: [String]?, question: String?) {
        print("setUsedTextLabel")
        guard let used_texts = usedTexts else {
            print("usedTexts is nil.")
            return
        }
        
        self.initUsedTextLabels(used_texts: used_texts, question: question)
        
        for usedTextLabel in self.usedTextLabels {
            for TextLabel in usedTextLabel!{
                    TextLabel.sizeToFit()
                    self.addSubview(TextLabel)
                }
            }
        }
    
    // 使用した英単語のLabelを作成する関数
    private func initUsedTextLabels(used_texts: [String], question: String?) {
        self.usedTextLabels = {
            let TextLabels = used_texts.enumerated().map({(idx,text) -> [UILabel]? in
                let resultlabels = result_label(string: text, index: idx, view: self)
//                if text.lowercased().contains(question){
                    resultlabels?.forEach { label in
                        self.addSubview(label)
                    }
//                }
                return resultlabels
            })
            return TextLabels
        }()
    }
}
