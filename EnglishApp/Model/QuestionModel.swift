import Foundation

// お題や使用した英単語を保持するクラス
// お題に関係する内部的な処理は全てここで行う
class QuestionModel: NSObject {
    
    private let questions = ["Phone", "Dog", "Cat", "Person", "Terminal"] // お題のリスト
    private var usedText: [String] = [] // お題を完成させるのに使用した英単語
    var question: String // お題
    
    override init() {
        // お題を初期化する
        self.question = self.questions.randomElement()!
        
        super.init()
    }
}

extension QuestionModel: QuestionViewDataSource {
    var questionString: String {
        return self.question
    }
}

extension QuestionModel: ResultViewDataSource {
    var usedTextString: [String] {
        return self.usedText
    }
}
