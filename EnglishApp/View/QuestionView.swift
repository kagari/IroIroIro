import Foundation
import UIKit
import AVFoundation

protocol QuestionViewDelegate: class {
    func goSkip(_: UIButton)
}

class QuestionView: UIView {
    
    var delegate: QuestionViewDelegate?
    
    let skipImage = UIImage(named: "skip")!
    var skipButton = UIButton()
//    var skipLabel = UILabel()
    var speechSynthesizer : AVSpeechSynthesizer!
    var questionLabel: UILabel!
    var topLabel: UILabel! //頭文字のラベル
    var searchLabel: UILabel! //"を探そうのラベル"
    
    var image: UIImage!
    var imageView: UIImageView!
    // 初期化関数
    override init(frame: CGRect) {
        self.speechSynthesizer = AVSpeechSynthesizer()
        
        super.init(frame: frame)
        
        self.makeSkipButton()
        
        self.questionLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 50)
            label.textAlignment = .center
            return label
        }()
        
        self.topLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 200)
            label.textAlignment = .center
            return label
        }()
        
        self.searchLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 50)
            label.textAlignment = .center
            return label
        }()
        
        self.addSubview(self.questionLabel)
        self.addSubview(self.topLabel)
        self.addSubview(self.searchLabel)
        self.backgroundColor = .white
    }
    
    // ここは上のinit関数と全く同じことを書けばOK
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - 多分レイアウトが変更されたときに呼び出される
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.frame.height
        let width = self.frame.width
        let buttonSize = width*0.1
        let buttonRect = CGRect(x: 0, y: height*0.85, width: buttonSize, height: buttonSize)
        
        self.questionLabel.frame = CGRect(x: 0, y: 0, width: width*0.8, height: height*0.2)
        self.questionLabel.center.x = self.center.x
        self.questionLabel.font = UIFont.systemFont(ofSize: width*0.07)
        
        self.topLabel.frame = CGRect(x: 0, y: height*0.8, width: width*0.8, height: height*0.2)
        self.topLabel.center.x = width*1/5
        self.topLabel.font = UIFont.systemFont(ofSize: height*0.1)
        
        self.searchLabel.frame = CGRect(x: 0, y: height-height*0.2, width: width*0.8, height: height*0.2)
        self.searchLabel.center.x = self.center.x
        self.searchLabel.font = UIFont.systemFont(ofSize: width*0.07)
        
        self.skipButton.frame = buttonRect
        self.skipButton.center.x = width*3/4
        self.skipButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.skipButton.layer.cornerRadius = buttonSize/2
        
//        self.skipLabel.frame = CGRect(x: 0, y: self.skipButton.frame.maxY, width: buttonSize, height: width*0.05)
//        self.skipLabel.center.x = width*3/4
        
        self.imageView.frame = CGRect(x: 0, y: height*0.8, width: width*0.8, height: height*0.5 )
        self.imageView.center = self.center
    }
    
    func makeSkipButton() {
        // skipアイコンを設置
        self.skipButton.setImage(skipImage, for: .init())
        self.skipButton.imageView?.contentMode = .scaleToFill
        self.skipButton.contentHorizontalAlignment = .fill
        self.skipButton.contentVerticalAlignment = .fill
        
        self.skipButton.backgroundColor = UIColor(rgb: 0x78CCD0)
        self.skipButton.addTarget(self, action: #selector(goSkip(button:)), for: .touchUpInside)
        self.addSubview(self.skipButton)
        
//        self.skipLabel.text = "スキップ"
//        self.skipLabel.textAlignment = .center
//        self.skipLabel.textColor = UIColor(rgb: 0x78CCD0)
//        self.addSubview(self.skipLabel)
    }
    
    // MARK: - QuestionModelからお題のデータを受け取ってセットする関数
    func setQuestionLabel(questionString: String?, questionAlphabet: String?) {
        print("setQuestionLabel")
        self.questionLabel.text = questionString! + "を完成させよう"
        self.questionLabel.sizeToFit()
        
        self.topLabel.text = questionAlphabet
        self.topLabel.sizeToFit()
        
        self.searchLabel.text = "を探してね"
        self.searchLabel.sizeToFit()
        
        if questionString != nil && questionAlphabet != nil {
            if questionString!.prefix(1) == questionAlphabet! {
                let utterance1 = AVSpeechUtterance(string: questionString!) // 読み上げるtext
                utterance1.voice = AVSpeechSynthesisVoice(language: "en-US") // 言語
                utterance1.rate = 0.5; // 読み上げ速度
                utterance1.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
                utterance1.preUtteranceDelay = 0.2; // 読み上げるまでのため
                self.speechSynthesizer.speak(utterance1)
                
                let utterance2 = AVSpeechUtterance(string: "を完成させよう") // 読み上げるtext
                utterance2.voice = AVSpeechSynthesisVoice(language: "ja-JP") // 言語
                utterance2.rate = 0.5; // 読み上げ速度
                utterance2.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
                utterance2.preUtteranceDelay = 0.2; // 読み上げるまでのため
                self.speechSynthesizer.speak(utterance2)
                
                let utterance3 = AVSpeechUtterance(string: questionAlphabet!) // 読み上げるtext
                utterance3.voice = AVSpeechSynthesisVoice(language: "ja-JP") // 言語
                utterance3.rate = 0.5; // 読み上げ速度
                utterance3.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
                utterance3.preUtteranceDelay = 0.2; // 読み上げるまでのため
                self.speechSynthesizer.speak(utterance3)
                
                let utterance4 = AVSpeechUtterance(string: "を探してね") // 読み上げるtext
                utterance4.voice = AVSpeechSynthesisVoice(language: "ja-JP") // 言語
                utterance4.rate = 0.5; // 読み上げ速度
                utterance4.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
                utterance4.preUtteranceDelay = 0.2; // 読み上げるまでのため
                self.speechSynthesizer.speak(utterance4)
            } else {
                let utterance3 = AVSpeechUtterance(string: questionAlphabet!) // 読み上げるtext
                utterance3.voice = AVSpeechSynthesisVoice(language: "ja-JP") // 言語
                utterance3.rate = 0.5; // 読み上げ速度
                utterance3.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
                utterance3.preUtteranceDelay = 0.2; // 読み上げるまでのため
                self.speechSynthesizer.speak(utterance3)
                
                let utterance4 = AVSpeechUtterance(string: "を探してね") // 読み上げるtext
                utterance4.voice = AVSpeechSynthesisVoice(language: "ja-JP") // 言語
                utterance4.rate = 0.5; // 読み上げ速度
                utterance4.pitchMultiplier = 1.0; // 読み上げる声のピッチ(1.0でSiri)
                utterance4.preUtteranceDelay = 0.2; // 読み上げるまでのため
                self.speechSynthesizer.speak(utterance4)
            }
        }
    }
    
    func setQuestionImage(name: String){
        self.image = UIImage(named: name)
        self.imageView = UIImageView(image: image)
        self.addSubview(self.imageView!)
    }
    
    // スキップボタンが押された時に呼ばれるメソッド
    @objc func goSkip(button: UIButton) {
        print("skip")
        delegate?.goSkip(button)
    }
    
}
