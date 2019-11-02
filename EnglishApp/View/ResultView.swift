import Foundation
import UIKit

protocol ResultViewDataSource: class {
    var usedTextString: [String] { get }
}

class ResultView: UIView {
    
    weak var dataSource: ResultViewDataSource?
    var usedTextLabel: [UILabel]!
    
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
    func setUsedTextLabel() {
        print("setUsedTextLabel")
        guard let used_text = dataSource?.usedTextString else {
            print("dataSource?.usedTextString is nil.")
            return
        }
        initUsedTextLabel(used_text: used_text)
    }
    
    // 使用した英単語のLabelを作成する関数
    private func initUsedTextLabel(used_text: [String]) {
        usedTextLabel = {
            let TextLabels = used_text.map({(text) -> UILabel in
                let label = UILabel()
                label.text = text
                label.textColor = UIColor(rgb: 0xFF65B2)
                label.font = UIFont(name: "Menlo", size: 50)
                label.textAlignment = .center
                return label
            })
            return TextLabels
        }()
    }
}
