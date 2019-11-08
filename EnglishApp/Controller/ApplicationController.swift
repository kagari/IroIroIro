import Foundation
import UIKit

class ApplicationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startViewController = StartViewController()
        startViewController.startView.delegate = startViewController
        self.view = startViewController.view
    }
}
