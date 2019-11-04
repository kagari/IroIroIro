import Foundation
import UIKit
import ARKit

class ARViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        
        let scene = SKScene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        sceneView.presentScene(scene)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
}

extension ARViewController: ARSKViewDelegate, ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        print("HeyHey")
    }
}
