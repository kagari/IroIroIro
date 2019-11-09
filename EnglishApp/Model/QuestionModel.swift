import Foundation

// お題に関係する内部的な処理は全てここで行う
class QuestionModel: NSObject {
    
    private let dataStorage :QuestionDataSingleton
    
    override init() {
        // データを初期化する
        dataStorage =  QuestionDataSingleton.sharedInstance
        
        super.init()
    }
    
    func saveUsedText(string: String?) {
        guard let usedText = string else {
            return
        }
        dataStorage.saveUsedText(usedText: usedText)
    }
}

extension QuestionModel: QuestionViewDataSource {
    var questionString: String? {
        return self.dataStorage.getQuestion()
    }
}

extension QuestionModel: ResultUsedTextViewDataSource {
    var usedTextString: [String]? {
        return self.dataStorage.getUsedTextList()
    }
}
