import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    let usedTextResultView: ResultView
    let questionModel: QuestionModel
    
    init() {
        self.usedTextResultView = ResultView()
        self.questionModel = QuestionModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("Called: ResultViewController")
        super.viewDidLoad()
        
        self.usedTextResultView.dataSource = self.questionModel
        
        self.usedTextResultView.setUsedTextLabels()
        self.view = self.usedTextResultView
    }
}
