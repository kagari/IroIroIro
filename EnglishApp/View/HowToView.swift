import UIKit

protocol HowToViewDelegate: class {
    func onbackClick(_:UIButton)
}

class HowToView: UIView {
    var delegate: HowToViewDelegate?
    private var eventLabel: UILabel?
    private var eventLabel2: UILabel?
    private var backBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        //遊び方ラベル
        self.eventLabel = UILabel()
        self.eventLabel?.text = "遊び方"
        self.eventLabel?.textColor = .red
        self.eventLabel?.font = UIFont.systemFont(ofSize: 80)
        self.eventLabel?.textAlignment = .center
        self.addSubview(self.eventLabel!)
    
        //遊び方説明ラベル
        self.eventLabel2 = UILabel()
        self.eventLabel2?.text = "1.你好 2.他是我的朋友 3.我想喝珍珠奶茶"
        self.eventLabel2?.font = UIFont.systemFont(ofSize: 50)
        self.addSubview(self.eventLabel2!)
    
        //戻るボタン
        self.backBtn = UIButton()
        self.backBtn?.setTitle("戻る", for: UIControl.State())
        self.backBtn?.setTitleColor(.orange, for: UIControl.State())
        self.backBtn?.backgroundColor = .white
        self.backBtn?.layer.cornerRadius = 10.0
        self.backBtn?.layer.borderColor = UIColor.orange.cgColor
        self.backBtn?.layer.borderWidth = 1.0
        self.backBtn?.addTarget(self, action: #selector(onbackClick(button:)), for: .touchUpInside)
        self.addSubview(self.backBtn!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        
        self.eventLabel?.frame = CGRect(x: 0, y: height*0.1, width: width, height: 100)
        
        self.eventLabel2?.frame = CGRect(x: width*0.1, y: height*0.3, width: width*0.8, height: 200)
        self.backBtn?.frame = CGRect(x: width*0.7 , y: height*0.9, width: 200, height: 30)
    }
    
    @objc func onbackClick(button: UIButton) {
        delegate?.onbackClick(button)
    }
}
