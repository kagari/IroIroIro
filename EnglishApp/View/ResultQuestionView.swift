import Foundation
import UIKit

class ResultQuestionView: UIView {
    
    weak var dataSource: QuestionViewDataSource?
    private var questionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        questionLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 100)
            label.textAlignment = .center
            return label
        }()
        
        self.addSubview(questionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        questionLabel.sizeToFit()
    }
    
    func setQuestionLabel() {
        print("setQuestionLabel")
        questionLabel.text = dataSource?.questionString
    }
}
