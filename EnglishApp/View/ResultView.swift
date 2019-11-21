import Foundation
import UIKit

protocol ResultViewDelegate: class {
    func goHome(_:UIButton)
    func goNextGame(_:UIButton)
}

class ResultView: UIView {
    
    var delegate: ResultViewDelegate?
    
    var usedTextLabels: [UILabel]!
    var questionLabel: UILabel!
    
    let homeImage = UIImage(named: "home")!
    let retryImage = UIImage(named: "retry")!
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
//        self.goHomeButton.setTitle("おわる", for: .init())
//        self.goHomeButton.setTitleColor(.white, for: .init())
        // homeアイコンを設置
        self.goHomeButton.setImage(homeImage, for: .init())
        self.goHomeButton.imageView?.contentMode = .scaleToFill
        self.goHomeButton.contentHorizontalAlignment = .fill
        self.goHomeButton.contentVerticalAlignment = .fill
        
        self.goHomeButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.goHomeButton.addTarget(self, action: #selector(goHome(button:)), for: .touchUpInside)
        self.addSubview(self.goHomeButton)
    }
    
    // もういちど
    func makeGoNextGameButton() {
//        self.goNextGameButton.setTitle("もういちど", for: .init())
//        self.goNextGameButton.setTitleColor(.white, for: .init())
        // homeアイコンを設置
        self.goNextGameButton.setImage(retryImage, for: .init())
        self.goNextGameButton.imageView?.contentMode = .scaleToFill
        self.goNextGameButton.contentHorizontalAlignment = .fill
        self.goNextGameButton.contentVerticalAlignment = .fill
        
        self.goNextGameButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.goNextGameButton.addTarget(self, action: #selector(goNextGame(button:)), for: .touchUpInside)
        self.addSubview(self.goNextGameButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        
        self.questionLabel.sizeToFit()
        
        self.goHomeButton.frame = CGRect(x: 0, y: height*0.7, width: width*0.2, height: width*0.2)
        self.goHomeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.goHomeButton.layer.cornerRadius = width*0.1/2
        self.goHomeButton.center.x = width*1/4

        self.goNextGameButton.frame = CGRect(x: 0, y: height*0.7, width: width*0.2, height: width*0.2)
        self.goNextGameButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.goNextGameButton.layer.cornerRadius = width*0.1/2
        self.goNextGameButton.center.x = width*3/4
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
    @objc func goHome(button: UIButton) {
        print("goHome")
        delegate?.goHome(button)
    }
    
    // "もういちど"ボタンが押された時に呼ばれるメソッド
    @objc func goNextGame(button: UIButton) {
        print("goNextGame")
        delegate?.goNextGame(button)
    }
}
