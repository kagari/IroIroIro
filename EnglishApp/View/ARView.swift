import Foundation
import UIKit
import ARKit

protocol ARViewDelegate {
    func tapGesture(identifier: String?)
}

class ARView: UIView, ARSKViewDelegate, ARSessionDelegate, ObjectDetectionModelDelegate {
    
    var delegate: ARViewDelegate?
    var sceneView: ARSKView
    var identifier: String?
    var questionLabel: UILabel?
    let objectDetectionModel: ObjectDetectionModel
    let configuration: ARConfiguration
    var objectLabel: UILabel!

    override init(frame: CGRect) {
        self.sceneView = ARSKView()
        self.objectDetectionModel = ObjectDetectionModel()
        self.configuration = ARWorldTrackingConfiguration()
        
        super.init(frame: frame)
        
        self.addSubview(self.sceneView)
        
        self.setUpARView()
        
        objectLabel = {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.font = UIFont(name: "Menlo", size: 50)
            label.textAlignment = .center
            return label
        }()
        self.addSubview(objectLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpARView() {
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        self.objectDetectionModel.delegate = self
        
        let scene = SKScene(size: self.sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        self.sceneView.presentScene(scene)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gestureRecognizer:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setQuestionLabel(question: String?, index: Int) {
        let baseUILabel = makeBaseUILabels(string: question, index: index)
        let uilabels = setUILabelSize(uilabels: baseUILabel, x: 0, y: self.frame.size.height*0.05, width: self.frame.size.width)
        uilabels?.forEach { label in
            self.addSubview(label)
        }
    }
    
    func setCorrectLabel() {
        let maru = UILabel()
        maru.text = "◯"
        maru.textColor = .red
        maru.font = UIFont.systemFont(ofSize: 300)
        maru.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.45)
        maru.center = self.center
        maru.textAlignment = .center
        maru.tag = 11
        self.addSubview(maru)

        let maru2 = UILabel()
        maru2.text = "correct:)"
        maru2.textColor = .red
        maru2.font = UIFont.systemFont(ofSize: 100)
        maru2.frame = CGRect(x: 0, y: maru.frame.minY - self.frame.height*0.2/2, width: self.frame.width, height: self.frame.height*0.2)
        maru2.center.x = maru.frame.midX
        maru2.textAlignment = .center
        maru2.tag = 11
        self.addSubview(maru2)
    }
    
    func setWrongLabel() {
        let batsu = UILabel()
        batsu.text = "×"
        batsu.textColor = .blue
        batsu.font = UIFont.systemFont(ofSize: 500)
        batsu.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.45)
        batsu.center = self.center
        batsu.textAlignment = .center
        batsu.tag = 11
        self.addSubview(batsu)
        
        let batsu2 = UILabel()
        batsu2.text = "wrong:("
        batsu2.textColor = .blue
        batsu2.font = UIFont.systemFont(ofSize: 100)
        batsu2.frame = CGRect(x: 0, y: batsu.frame.minY - self.frame.height*0.2/2, width: self.frame.width, height: self.frame.height*0.2)
        batsu2.center.x = batsu.frame.midX
        batsu2.textAlignment = .center
        batsu2.tag = 11
        self.addSubview(batsu2)
    }
    
    func setAlert(callback: @escaping () -> Void) {
        let width = self.frame.width
        let height = self.frame.height
        
        let rect = CGRect(x: 0, y: 0, width: width*0.8, height: height*0.2)
        let sameWordAlert = SameWordAlertView(frame: rect)
        sameWordAlert.tag = 20
        sameWordAlert.center = self.center
        self.addSubview(sameWordAlert)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            sameWordAlert.removeFromSuperview()
            callback()
        }
    }
    
    func startSession() {
        self.sceneView.session.run(self.configuration)
    }
    
    func pauseSession() {
        self.sceneView.session.pause()
    }
    
    override func layoutSubviews() {
        self.sceneView.frame = self.frame
        self.questionLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let bounds = self.sceneView.bounds.size
        self.objectDetectionModel.classifyCurrentImage(frame: frame, bounds: bounds)
    }
    
    // MARK: - ObjectDetectionModelDelegate
    func detectionFinished(identifier: String?, objectBounds: CGRect?) {
        print("detectionFinished!!")
        
        self.subviews.filter({$0.tag == 10}).forEach { view in // delete ObjectRoundedLineView
            view.removeFromSuperview()
        }
        
        if let objectBounds = objectBounds, let identifier = identifier {
            
            let objectRoundedLineView = UIView(frame: objectBounds)
            objectRoundedLineView.tag = 10
            objectRoundedLineView.backgroundColor = UIColor(rgba: 0xf0ea9e)
            // set tap gesture
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gestureRecognizer:)))
            objectRoundedLineView.addGestureRecognizer(tapGestureRecognizer)
            
            self.identifier = identifier
            // 名前を物体の枠の中央に表示
            self.objectLabel.text = self.identifier
            self.objectLabel.font = UIFont(name: "Menlo", size: 100)
            self.objectLabel.adjustsFontSizeToFitWidth = true
            self.objectLabel.frame = CGRect(x: 0, y: 0,width: objectBounds.width, height: objectBounds.height)
            self.objectLabel.center = objectRoundedLineView.center
            self.objectLabel.textAlignment = .center
            self.objectLabel.tag = 10
            self.addSubview(self.objectLabel)
            
            self.addSubview(objectRoundedLineView)
        } else {
            print("Object detection is failed.")
        }
        
        // move UILabel to foreground
        self.subviews.filter({$0 is UILabel}).forEach { label in
            self.bringSubviewToFront(label)
        }
        
        // alertのViewがあれば一番前面に持ってくる
        self.subviews.filter({$0.tag == 20}).forEach { alert in
            self.bringSubviewToFront(alert)
        }
    }
    
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.tapGesture(identifier: self.identifier)
    }
}

class SameWordAlertView: UIView {
    let alertLabel: UILabel
    
    override init(frame: CGRect) {
        self.alertLabel = {
            let label = UILabel()
            label.text = "同じ単語は使えないよ！\nちがう単語をさがしてね"
            label.font = UIFont(name: "Menlo", size: 80)
            label.textColor = UIColor(rgb: 0xFF65B2)
            label.textAlignment = .center
            label.numberOfLines = 2
            label.adjustsFontSizeToFitWidth = true
            
            return label
        }()
        
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.layer.borderColor = UIColor(rgb: 0x78CCD0).cgColor
        
        self.addSubview(self.alertLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        
        self.layer.borderWidth = width*0.01
        self.layer.cornerRadius = height*0.1
        
        self.alertLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.alertLabel.center = CGPoint(x: width/2, y: height/2)
    }
}
