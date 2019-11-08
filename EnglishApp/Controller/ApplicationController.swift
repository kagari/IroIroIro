import Foundation
import UIKit

class ApplicationController: UIViewController {
    
    var arViewController: ARViewController!
    var questionViewController: QuestionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startView = StartView() // スタート画面を作成
        self.view = startView
    }
}
