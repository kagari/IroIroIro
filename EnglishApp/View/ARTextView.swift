import Foundation
import UIKit

protocol ObjectDetectionModelDataSource: class {
    var identifierString: String? { get }
}

class ARTextView: UIView {
    
    weak var dataSource: ObjectDetectionModelDataSource?
    var identifierLabel: [UILabel]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for label in self.subviews {
            label.removeFromSuperview()
        }
        
        for label in self.identifierLabel! {
            self.addSubview(label)
        }
    }
    
    func setIdentifierLabel() {
        print("setIdentifierLabel")
        
        guard let identifier = dataSource?.identifierString else {
            return
        }
        
        self.identifierLabel = make_label(string: identifier, view: self)
    }
}
