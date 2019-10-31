import Foundation
import UIKit

class QuestionViewController: UIViewController, QuestionViewDelegate {
    
    let questions:[String] = ["Phone", "Dog", "Cat", "Hoge", "Terminal"]
    private let titleName: String!
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        let view = QuestionView()
        view.delegate = self
        self.view = view
    }
    
    func hoge() {
        print("Hogeeeee!!!!")
    }
}
