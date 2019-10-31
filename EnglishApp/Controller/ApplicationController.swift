import Foundation
import UIKit

class ApplicationController: UIViewController {
    
    var startViewController: StartViewController!
    var arViewController: ARViewController!
    var questionViewController: QuestionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startViewController = StartViewController()
    }
}
