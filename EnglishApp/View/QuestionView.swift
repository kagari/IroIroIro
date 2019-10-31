import Foundation
import UIKit

protocol QuestionViewDelegate: class {
    func hoge()
}

class QuestionView: UIView {
    
    // QuestionViewDelegateのインスタンスを宣言
    var delegate: QuestionViewDelegate?
    
    // 初期化関数
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // ここは上のinit関数と全く同じことを書けばOK
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - 多分レイアウトが変更されたときに呼び出される
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
