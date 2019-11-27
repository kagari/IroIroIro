import Foundation
import UIKit
import AVFoundation

class QuestionView: UIView {
    
    var speechSynthesizer : AVSpeechSynthesizer!
    var questionLabel: UILabel!
    var topLabel: UILabel! //頭文字のラベル
    var searchLabel: UILabel! //"を探そうのラベル"
    
    
    // 初期化関数
    override init(frame: CGRect) {
        self.speechSynthesizer = AVSpeechSynthesizer()
        
        super.init(frame: frame)
        
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
        
        self.questionLabel.frame = CGRect(x: 0, y: 0, width: width*0.8, height: height*0.2)
        self.questionLabel.center.x = self.center.x
        self.questionLabel.font = UIFont.systemFont(ofSize: width*0.07)
        
        self.topLabel.frame = CGRect(x: 0, y: 0, width: width*0.8, height: height*0.2)
        self.topLabel.center = self.center
        self.topLabel.font = UIFont.systemFont(ofSize: height*0.1)
        
        self.searchLabel.frame = CGRect(x: 0, y: height-height*0.2, width: width*0.8, height: height*0.2)
        self.searchLabel.center.x = self.center.x
        self.searchLabel.font = UIFont.systemFont(ofSize: width*0.07)
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
}
