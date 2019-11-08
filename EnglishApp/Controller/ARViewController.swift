import Foundation
import UIKit
import ARKit


// このクラスはStoryboardを使用している
class ARViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSKView!
    let objectDetectionModel = ObjectDetectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        
        let scene = SKScene(size: self.sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        self.sceneView.presentScene(scene)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }
}

extension ARViewController: ARSKViewDelegate, ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        self.objectDetectionModel.classifyCurrentImage(frame: frame)
    }
}

extension ARViewController: ObjectDetectionModelDelegate {
    func detectionFinished(identifier: String?, confidence: Float?) {
//        let label = UILabel()
//        label.text = identifier
//        label.textColor = UIColor(rgb: 0xFF65B2)
//        label.font = UIFont(name: "Menlo", size: 50)
//        label.textAlignment = .center
//        self.sceneView.addSubview(label)
        print("呼び出されている？")
    }
}
