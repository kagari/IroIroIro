import Foundation
import UIKit

class ApplicationController: UIViewController, StartViewDelegate {
    
    // インスタンスを作成し、それぞれのインスタンスの
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = StartView(frame: self.view.frame)
        view.delegate = self
        self.view.addSubview(view)
    }
    
    func didTapStartButton() {
        print("Startボタンがタップされた")
    }
}
