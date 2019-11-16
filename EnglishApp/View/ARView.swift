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
    
    
    override init(frame: CGRect) {
        self.sceneView = ARSKView()
        self.objectDetectionModel = ObjectDetectionModel()
        self.configuration = ARWorldTrackingConfiguration()
        
        super.init(frame: frame)
        
        self.addSubview(self.sceneView)
        
        self.setUpARView()
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
    
    func setQuestionLabel(question: String?) {
        let uilabels = make_label(string: question, view: self)
        uilabels?.forEach { label in
            self.addSubview(label)
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
        
        self.identifier = identifier
        
//        self.subviews.forEach { subview in
//            if subview is UILabel {
//                subview.removeFromSuperview()
//            }
//        }
//        // 認識した物体の名前を表示
//        let uilabels = make_label(string: identifier, view: self)
//        uilabels?.forEach { label in
//            self.addSubview(label)
//        }
    }
    
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.tapGesture(identifier: self.identifier)
    }
}
