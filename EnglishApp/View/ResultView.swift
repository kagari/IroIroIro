import Foundation
import UIKit

class ResultView: UIView {
    
    var usedTextLabels: [UILabel]!
    var questionLabel: UILabel!
    var goHomeButton = UIButton()
    var goNextGameButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.makeGoHomeButton()
        self.makeGoNextGameButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // おわる
    func makeGoHomeButton() {
        self.goHomeButton.setTitle("おわる", for: .init())
        self.goHomeButton.setTitleColor(.white, for: .init())
        self.goHomeButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.goHomeButton.addTarget(self, action: #selector(goHome(_:)), for: .touchUpInside)
        self.addSubview(self.goHomeButton)
    }
    
    // もういちど
    func makeGoNextGameButton() {
        self.goNextGameButton.setTitle("もういちど", for: .init())
        self.goNextGameButton.setTitleColor(.white, for: .init())
        self.goNextGameButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.goNextGameButton.addTarget(self, action: #selector(goNextGame(_:)), for: .touchUpInside)
        self.addSubview(self.goNextGameButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        
        self.questionLabel.sizeToFit()
        
        self.goHomeButton.frame = CGRect(x: 0, y: height*0.65, width: width*0.5, height: height*0.08)
        self.goHomeButton.center.x = self.center.x
        self.goHomeButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.05)

        self.goNextGameButton.frame = CGRect(x: 0, y: height*0.8, width: width*0.5, height: height*0.08)
        self.goNextGameButton.center.x = self.center.x
        self.goNextGameButton.titleLabel?.font = UIFont.systemFont(ofSize: height*0.05)
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
    
    // "おわる"ボタンが押された時に呼ばれるメソッド
    @objc func goHome(_ sender: UIButton) {
        print("goHome")
    }
    
    // "おわる"ボタンが押された時に呼ばれるメソッド
    @objc func goNextGame(_ sender: UIButton) {
        print("goNextGame")
    }
}
