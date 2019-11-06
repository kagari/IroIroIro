import Foundation
import UIKit

protocol QuestionViewDataSource: class {
    var questionString: String? { get }
}

class QuestionView: UIView {
    
    weak var dataSource: QuestionViewDataSource?
    var questionLabel: UILabel!
    var topLabel: UILabel! //頭文字のラベル
    var searchLabel: UILabel! //"を探そうのラベル"
    
    // 初期化関数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        questionLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 50)
            label.textAlignment = .center
            return label
        }()
        
        topLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 200)
            label.textAlignment = .center
            return label
        }()
        
        searchLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 50)
            label.textAlignment = .center
            return label
        }()
        
        self.addSubview(questionLabel)
        self.addSubview(topLabel)
        self.addSubview(searchLabel)
        self.backgroundColor = .white
    }
    
    // ここは上のinit関数と全く同じことを書けばOK
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - 多分レイアウトが変更されたときに呼び出される
    override func layoutSubviews() {
        super.layoutSubviews()
        
        questionLabel.frame = CGRect(x: 100, y: 0, width: 0.8*self.frame.width, height: 0.2*self.frame.height)
        //questionLabel.layer.position = self.center
        
        topLabel.frame = CGRect(x: 0, y: 0, width: 0.8*self.frame.width, height: 0.2*self.frame.height)
        topLabel.layer.position = self.center
        
        searchLabel.frame = CGRect(x:100, y: 800, width: 0.8*self.frame.width, height: 0.2*self.frame.height)
        //searchLabel.layer.position = self.center
    }
    
    // MARK: - QuestionModelからお題のデータを受け取ってセットする関数
    func setQuestionLabel(questionString: String?, questionAlphabet: String?) {
        print("setQuestionLabel")
        questionLabel.text = questionString! + "を完成させよう"
        questionLabel.sizeToFit()
        
        topLabel.text = questionAlphabet
        topLabel.sizeToFit()
        
        searchLabel.text = "を探してね"
        searchLabel.sizeToFit()
    }
}
