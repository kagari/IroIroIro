import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    let usedTextResultView: ResultView
    
    init() {
        self.usedTextResultView = ResultView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("Called: ResultViewController")
        super.viewDidLoad()
        
//        self.usedTextResultView.dataSource = QuestionModel
        self.usedTextResultView.setUsedTextLabel()
        self.view = self.usedTextResultView
    }
}
