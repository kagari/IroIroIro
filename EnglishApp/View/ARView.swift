import Foundation
import UIKit
import ARKit


// このクラスはStoryboardを使用している
class ARView: UIView, ARSKViewDelegate, ARSessionDelegate, ObjectDetectionModelDelegate {
    
    var sceneView: ARSKView
    let objectDetectionModel: ObjectDetectionModel
    
    override init(frame: CGRect) {
        self.sceneView = ARSKView()
        self.objectDetectionModel = ObjectDetectionModel()
        
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
    
    func startSessionRun() {
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }
    
    override func layoutSubviews() {
        self.sceneView.frame = self.frame
    }
    
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let bounds = self.sceneView.bounds.size
        self.objectDetectionModel.classifyCurrentImage(frame: frame, bounds: bounds)
    }
    
    // MARK: - ObjectDetectionModelDelegate
    func detectionFinished(identifier: String?, objectBounds: CGRect?) {
        print("detectionFinished!!")
        self.subviews.forEach { subview in
            if subview is UILabel {
                subview.removeFromSuperview()
            }
        }
        // 認識した物体の名前を表示
        let uilabels = make_label(string: identifier, view: self)
        uilabels?.forEach { label in
            self.addSubview(label)
        }
    }
    
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer) {
        print("タップされたよ!!")
    }
}