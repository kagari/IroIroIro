import Foundation
import UIKit

class QuestionViewController: NSObject {
    
    weak var dataSource: QuestionViewDataSource?
    let questionModel: QuestionModel
    let questionView: QuestionView
    var question: String?
    var index: Int?
    
    override init() {
        self.questionModel = QuestionModel()
        self.questionView = QuestionView()
        self.index = 0
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        print("Called: QuestionViewController")
        
        self.dataSource = self.questionModel
        self.question = self.dataSource?.questionString
        
        self.questionView.setQuestionLabel(questionString: self.question, questionAlphabet: getAlphabet(index: index!))
    }
    
    func getAlphabet(index:Int) -> String? {
        //お題のn番目のアルファベットを取得したい
        return question?.map({String($0)})[index]
    }
    
    func setUsedObjectName(objectName: String?) {
        self.questionModel.saveUsedText(string: objectName)
    }
}
