import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    let questionModel: QuestionModel
    let questionView: QuestionView!
    
    init() {
        self.questionModel = QuestionModel()
        self.questionView = QuestionView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionView.dataSource = self.questionModel
        
        self.questionView.setQuestionLabel()
        self.view = self.questionView
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            // 3秒後にARの画面に遷移
//
//            let arViewController = ARViewController()
//            self.present(arViewController, animated: true, completion: nil)
//        }
    }
}
