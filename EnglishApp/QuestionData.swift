import Foundation

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
    static let sharedDataInstance: QuestionDataSingleton = QuestionDataSingleton()
    private override init() {}
    
    func saveUsedText(usedText: String) {
        data.usedTextList?.append(usedText)
    }

    func getUsedTextList() -> [String]? {
        return data.usedTextList
    }
    
    func getQuestion() -> String? {
        return data.question
    }
}
