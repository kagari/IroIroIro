import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    let resultUsedTextView: ResultUsedTextView
    let resultQuestionView: ResultQuestionView
    let questionModel: QuestionModel
    
    init() {
        self.resultUsedTextView = ResultUsedTextView()
        self.resultQuestionView = ResultQuestionView()
        self.questionModel = QuestionModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("Called: ResultViewController")
        super.viewDidLoad()
        
        self.resultUsedTextView.dataSource = self.questionModel
        self.resultQuestionView.dataSource = self.questionModel
        
        self.resultUsedTextView.setUsedTextLabels()
        self.view = self.resultUsedTextView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // 3秒後にResult画面に遷移
            self.resultQuestionView.setQuestionLabel()
            self.view = self.resultQuestionView
        }
    }
}
