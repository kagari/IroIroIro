import Foundation
import UIKit

class QuestionViewController: UIViewController, QuestionViewDelegate {
    
    let questions:[String] = ["Phone", "Dog", "Cat", "Hoge", "Terminal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = QuestionView()
        view.delegate = self
        self.view = view
    }
    
    func hoge() {
        print("Hogeeeee!!!!")
    }
}
