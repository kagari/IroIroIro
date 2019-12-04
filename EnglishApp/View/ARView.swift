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
        
        if let objectBounds = objectBounds {
            
            let objectRoundedLineView = UIView(frame: objectBounds)
            objectRoundedLineView.tag = 10
            objectRoundedLineView.backgroundColor = UIColor(rgba: 0xf0ea9e)
            // set tap gesture
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gestureRecognizer:)))
            objectRoundedLineView.addGestureRecognizer(tapGestureRecognizer)
            self.addSubview(objectRoundedLineView)
            
        } else {
            print("Object detection is failed.")
        }
        
        self.identifier = identifier
        // 物体の名前を中心に表示
        self.objectLabel.text = self.identifier
        self.objectLabel.font = UIFont(name: "Menlo", size: 100)
        self.objectLabel.frame = CGRect(x: 0, y: 0,width: self.frame.width, height: self.frame.height * 0.2)
        self.objectLabel.center = self.center
        self.objectLabel.textAlignment = .center
        self.objectLabel.tag = 10
        self.addSubview(self.objectLabel)
        
        // move UILabel to foreground
        self.subviews.filter({$0 is UILabel}).forEach { label in
            self.bringSubviewToFront(label)
        }
    }
    
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.tapGesture(identifier: self.identifier)
    }
}
