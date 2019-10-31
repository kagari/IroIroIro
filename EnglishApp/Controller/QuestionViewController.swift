import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel! // お題用のラベル
    let questions:[String] = ["Phone", "Dog", "Cat", "Hoge", "Terminal"]
    
    @IBOutlet weak var name: UILabel! //頭文字のラベル
    
    @IBOutlet weak var search: UILabel! //"を探そう"のラベル
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
          
      
      // let top = questions[0]
//        let labels = make_label(string: string, view: self.view)
//        for label in labels {
//            self.view.addSubview(label)
//        }

//        let top = question[0]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // 3秒後にARの画面に遷移
            self.performSegue(withIdentifier: "toARViewController", sender: nil)
        }
    }
    
    // MARK: - UIを整える関数
    private func setupUI() {
        let questionText = questions[Int(arc4random()) % questions.count]
        question.text = questionText + "を完成させよう！"
//        question.text = "DOGを完成させよう！！"
        question.textColor = .purple
        question.textAlignment = .center
        question.font = UIFont.systemFont(ofSize: 60.0)
        
        let top = String(questionText.prefix(1))
        name.text = String(top.prefix(1))
        name.textColor = .red
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 300.0)
        
        search.text = " を探そう"
        search.textColor = .purple
        search.textAlignment = .center
        search.font = UIFont.systemFont(ofSize: 60.0)
    }
}
