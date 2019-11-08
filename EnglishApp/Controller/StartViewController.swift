import Foundation
import UIKit

class StartViewController: NSObject, StartViewDelegate {
    
    var view: UIView
    let startView: StartView
    let howToView: HowToView
    
    override init() {
        self.startView = StartView()
        self.howToView = HowToView()
        self.view = startView
        super.init()
    }
    
    // MARK: - ボタンタップ時の挙動
    func buttonEvent(_: UIButton) {
        print("Startボタンが押された!!")
    }
    
    func goHowTo(_: UIButton) {
        print("説明ボタンが押された!!")
    }
    
    func goSetting(_: UIButton) {
        print("設定ボタンが押された!!")
    }
}
