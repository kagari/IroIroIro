import Foundation
import UIKit
import ARKit

class ARSearchObjectViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    private let objectDetectionModel: ObjectDetectionModel
    private var sceneView: ARSCNView
    
    init() {
        sceneView = ARSCNView()
        objectDetectionModel = ObjectDetectionModel()
        
        super.init(nibName: nil, bundle: nil)
        self.view = sceneView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.viewDidLoad()
        
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        
        self.sceneView.scene = SCNScene()
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
