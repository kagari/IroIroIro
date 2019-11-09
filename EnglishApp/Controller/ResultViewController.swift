import Foundation
import UIKit

class ResultViewController: NSObject {
    
    let resultUsedTextView: ResultUsedTextView
    let resultQuestionView: ResultQuestionView
    let questionModel: QuestionModel
    
    override init() {
        self.resultUsedTextView = ResultUsedTextView()
        self.resultQuestionView = ResultQuestionView()
        self.questionModel = QuestionModel()
        
        super.init()
        
        print("Called: ResultViewController")
        self.resultUsedTextView.dataSource = self.questionModel
        self.resultQuestionView.dataSource = self.questionModel
        
        self.resultQuestionView.setQuestionLabel()
        self.resultUsedTextView.setUsedTextLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
