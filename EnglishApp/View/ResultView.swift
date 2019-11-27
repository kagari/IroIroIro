import Foundation
import UIKit

protocol ResultViewDelegate: class {
    func goHome(_:UIButton)
    func goNextGame(_:UIButton)
}

class ResultView: UIView {
    
    var delegate: ResultViewDelegate?
    
    var usedTextLabels: [[UILabel]?] = []
    var questionLabel: UILabel!
    
    let homeImage = UIImage(named: "home")!
    let retryImage = UIImage(named: "retry")!
    var goHomeButton = UIButton()
    var goHomeLabel = UILabel()
    var goNextGameButton = UIButton()
    var goNextGameLabel = UILabel()
    
    var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.makeGoHomeButton()
        self.makeGoNextGameButton()
        
        self.descriptionLabel = {
            let label = UILabel()
            label.text = "見つけた英単語"
            label.textAlignment = .center
            label.textColor = UIColor(rgb: 0x78CCD0)
            label.font = UIFont(name: "Menlo", size: 50)
            return label
        }()
        self.addSubview(self.descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        let buttonSize = width*0.1
        let buttonRect = CGRect(x: 0, y: height*0.85, width: buttonSize, height: buttonSize)
        
        self.questionLabel.frame = CGRect(x: 0, y: 0, width: width, height: height*0.15)
        
        self.descriptionLabel.frame = CGRect(x: 0, y: height*0.2, width: width, height: height*0.02)
        
        self.goHomeButton.frame = buttonRect
        self.goHomeButton.center.x = width*1/4
        self.goHomeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.goHomeButton.layer.cornerRadius = buttonSize/2
        
        self.goHomeLabel.frame = CGRect(x: 0, y: self.goHomeButton.frame.maxY, width: buttonSize, height: width*0.05)
        self.goHomeLabel.center.x = width*1/4

        self.goNextGameButton.frame = buttonRect
        self.goNextGameButton.center.x = width*3/4
        self.goNextGameButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.goNextGameButton.layer.cornerRadius = buttonSize/2
        
        self.goNextGameLabel.frame = CGRect(x: 0, y: self.goNextGameButton.frame.maxY, width: buttonSize, height: width*0.05)
        self.goNextGameLabel.center.x = width*3/4
    }
    
    // おわる
    func makeGoHomeButton() {
        // homeアイコンを設置
        self.goHomeButton.setImage(homeImage, for: .init())
        self.goHomeButton.imageView?.contentMode = .scaleToFill
        self.goHomeButton.contentHorizontalAlignment = .fill
        self.goHomeButton.contentVerticalAlignment = .fill
        
        self.goHomeButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.goHomeButton.addTarget(self, action: #selector(goHome(button:)), for: .touchUpInside)
        self.addSubview(self.goHomeButton)
        
        self.goHomeLabel.text = "おわる"
        self.goHomeLabel.textAlignment = .center
        self.goHomeLabel.textColor = UIColor(rgb: 0x78CCD0)
        self.addSubview(self.goHomeLabel)
    }
    
    // もういちど
    func makeGoNextGameButton() {
        // repeatアイコンを設置
        self.goNextGameButton.setImage(retryImage, for: .init())
        self.goNextGameButton.imageView?.contentMode = .scaleToFill
        self.goNextGameButton.contentHorizontalAlignment = .fill
        self.goNextGameButton.contentVerticalAlignment = .fill
        
        self.goNextGameButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.goNextGameButton.addTarget(self, action: #selector(goNextGame(button:)), for: .touchUpInside)
        self.addSubview(self.goNextGameButton)
        
        self.goNextGameLabel.text = "もういちど"
        self.goNextGameLabel.textAlignment = .center
        self.goNextGameLabel.textColor = UIColor(rgb: 0x78CCD0)
        self.addSubview(self.goNextGameLabel)
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
            print("usedTexts is nil...")
            return
        }
        guard let question = question else {
            print("question is nil...")
            return
        }

        guard let count = used_texts.map({$0.count}).max() else { // get max length of used text
            print("count is nil...")
            return
        }
        
        let labelSizeBaseStringCount = self.frame.width*0.8/CGFloat(count)
        let labelSizeBaseQuestionLength = self.frame.height*0.35/CGFloat(question.count)
        let labelSize = min(labelSizeBaseQuestionLength, labelSizeBaseStringCount)
        var y = self.frame.height*0.28
        
        for (q, text) in zip(question.lowercased(), used_texts) {
            guard let idx = text.lowercased().firstIndex(of: q) else {
                print("not found \(q) from \(text)")
                continue
            }
            
            let index = text.distance(from: text.startIndex, to: idx)
            
            let labels = makeUILabelsForUsedTextLabel(string: text, index: index, x: self.frame.width*0.1, y: CGFloat(y), labelSize: labelSize)
            
            self.usedTextLabels.append(labels)
            y += labelSize*1.5
        }
        
        for usedTextLabel in self.usedTextLabels {
            usedTextLabel?.forEach { text in
                self.addSubview(text)
            }
        }
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
