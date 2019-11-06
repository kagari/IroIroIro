import Foundation
import UIKit

class ApplicationController: UIViewController {
    
    var startViewController: ViewController!
    var arViewController: ARViewController!
    var questionViewController: QuestionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 一番始めの画面遷移
        startViewController = ViewController()
        startViewController.modalPresentationStyle = .fullScreen
        self.present(startViewController, animated: false, completion: nil)
    }
}
