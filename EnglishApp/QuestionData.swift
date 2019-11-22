import Foundation

// お題や使用した英単語を保持するクラス
class QuestionData {
    let questions: [String]
    var question: String?
    var usedTextList: [String]
    var alphabet: Character?
    
    init() {
//        , "Dog", "Cat", "Person", "Terminal"
        self.questions = ["Phone"]
        self.question = questions.randomElement()
//        ダミーデータ
        self.usedTextList = ["person","cell phone","laptop","tvmonitor","bottle"]
    }
    
    // MARK: - setter, getter
    func addUsedText(usedText: String?) {
        guard let usedText = usedText else {
            print("usedText is nil...")
            return
        }
        self.usedTextList.append(usedText)
    }
    
    func getUsedTextList() -> [String] {
        return self.usedTextList
    }
    
    func getQuestion() -> String? {
        return self.question
    }
}
