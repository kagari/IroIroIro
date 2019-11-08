import Foundation
import UIKit
import ARKit


// このクラスはStoryboardを使用している
class ARViewController: UIViewController, ARSKViewDelegate, ARSessionDelegate, ObjectDetectionModelDelegate {
    
    @IBOutlet weak var sceneView: ARSKView!
    let objectDetectionModel = ObjectDetectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.delegate = self
        self.sceneView.session.delegate = self
        self.objectDetectionModel.delegate = self
        
        let scene = SKScene(size: self.sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        self.sceneView.presentScene(scene)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gestureRecognizer:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }
    
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let bounds = self.sceneView.bounds.size
        self.objectDetectionModel.classifyCurrentImage(frame: frame, bounds: bounds)
    }
    
    // MARK: - ObjectDetectionModelDelegate
    func detectionFinished(identifier: String?, objectBounds: CGRect?) {
        print("detectionFinished!!")
        self.view.subviews.forEach { subview in
            if subview is UILabel {
                subview.removeFromSuperview()
            }
        }
        // 認識した物体の名前を表示
        let uilabels = make_label(string: identifier, view: self.view)
        uilabels?.forEach { label in
            self.view.addSubview(label)
        }
    }
    
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer) {
        print("タップされたよ!!")
    }
}
