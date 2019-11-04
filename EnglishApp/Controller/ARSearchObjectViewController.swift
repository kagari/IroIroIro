import Foundation
import UIKit
import ARKit

class ARSearchObjectViewController: UIViewController {
    
    let objectDetectionModel: ObjectDetectionModel
    let sceneView: ARSKView
    
    init() {
        self.objectDetectionModel = ObjectDetectionModel()
        self.sceneView = ARSKView()
        super.init(nibName: nil, bundle: nil)
        self.view = self.sceneView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.viewDidLoad()
        
//        self.sceneView.delegate = self
//        self.sceneView.session.delegate = self
        let scene = SKScene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        sceneView.presentScene(scene)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

extension ARSearchObjectView: ARSKViewDelegate, ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        print("呼び出せてる？")
//        self.objectDetectionModel.classifyCurrentImage(frame: frame)
    }
}
