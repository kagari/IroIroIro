import Foundation

// お題や使用した英単語を保持するクラス
class QuestionData {
    let questions: [String]
    var question: String?
    var usedTextList: [String]?
    var alphabet: Character?
    
    init() {
        self.questions = ["Phone", "Dog", "Cat", "Person", "Terminal"]
        self.question = questions.randomElement()
    }
}

class QuestionDataSingleton: NSObject {
    var data = QuestionData()
    static let sharedInstance: QuestionDataSingleton = QuestionDataSingleton()
    private override init() {}
    
    // MARK: - setter, getter
    func saveUsedText(usedText: String) {
        if data.usedTextList != nil {
            data.usedTextList?.append(usedText) // データがある場合には普通にappend
        } else {
            data.usedTextList = [usedText] // データがない(nilの)場合には初期化する
        }
    }

    func getUsedTextList() -> [String]? {
        return data.usedTextList
    }
    
    func getQuestion() -> String? {
        return data.question
    }
}
