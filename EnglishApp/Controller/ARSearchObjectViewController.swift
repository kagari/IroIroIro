import Foundation
import UIKit
import SpriteKit
import ARKit

class ARSearchObjectViewController: UIViewController, ARSKViewDelegate, ARSessionDelegate {
    
    private let objectDetectionModel: ObjectDetectionModel
    private var sceneView: ARSKView
    
    init() {
        sceneView = ARSKView()
        objectDetectionModel = ObjectDetectionModel()
        
        super.init(nibName: nil, bundle: nil)
        self.view = sceneView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        //configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARのdelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // frame変数ごと物体認識のクラスに渡す
        self.objectDetectionModel.classifyCurrentImage(frame: frame)
    }
}
