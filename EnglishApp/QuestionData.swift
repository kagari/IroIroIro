import Foundation

// お題や使用した英単語を保持するクラス
class QuestionData {
    let questions: [String]
    var question: String?
    var usedTextList: [String]?
    
    init() {
        self.questions = ["Phone", "Dog", "Cat", "Person", "Terminal"]
        self.question = questions.randomElement()
    }
}

class QuestionDataSingleton: NSObject {
    var data = QuestionData()
    static let sharedInstance: QuestionDataSingleton = QuestionDataSingleton()
    private override init() {}
    
    func saveUsedText(usedText: String) {
        if data.usedTextList != nil {
            data.usedTextList?.append(usedText)
        } else {
            data.usedTextList = [usedText]
        }
    }

    func getUsedTextList() -> [String]? {
        return data.usedTextList
    }
    
    func getQuestion() -> String? {
        return data.question
    }
}
