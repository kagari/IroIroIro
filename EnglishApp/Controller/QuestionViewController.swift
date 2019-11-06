import Foundation
import UIKit



class QuestionViewController: UIViewController {
    
    weak var dataSource: QuestionViewDataSource?
    let questionModel: QuestionModel
    let questionView: QuestionView
    var question: String?
    
    init() {
        self.questionModel = QuestionModel()
        self.questionView = QuestionView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        print("Called: QuestionViewController")
        super.viewDidLoad()
        
        self.questionView.dataSource = self.questionModel
        self.question = dataSource?.questionString
        
        self.questionView.setQuestionLabel()
        self.view = self.questionView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            // 3秒後にAR画面に遷移
//            let arSearchObjectViewController = ARSearchObjectViewController()
//            arSearchObjectViewController.modalPresentationStyle = .fullScreen
//            self.present(arSearchObjectViewController, animated: true, completion: nil)
            
            // TODO: これはUI班用
            // 3秒後にResult画面に遷移
            let resultViewController = ResultViewController()
            resultViewController.modalPresentationStyle = .fullScreen
            self.present(resultViewController, animated: true, completion: nil)
        }
    }
    
    func getAlphabet(index:Int) -> String? {
        return question?.map({String($0)})[index]
    }
}
