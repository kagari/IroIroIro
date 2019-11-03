import Foundation
import UIKit
import ARKit

class ARViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var objectLabel: UILabel!
    
    private let objectDetectionModel: ObjectDetectionModel
    private let arView: ARSearchObjectView
    private var currentBuffer: CVPixelBuffer?
    
    init() {
        objectDetectionModel = ObjectDetectionModel()
        arView = ARSearchObjectView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - stringの引数は、QuestionViewから受け取る
        let question_label = make_label(string: "Person", view: self.view) // お題のラベルを作成
        for elem in question_label {
            self.view.addSubview(elem) // お題のラベルを追加
        }
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
//    // MARK: - カメラからキャプチャしてMLに流す処理群
//    // ここでARのカメラからキャプチャした画像を処理する
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
//            return
//        }
//
//        self.currentBuffer = frame.capturedImage
//        objectDetectionModel.classifyCurrentImage() // VisionAPIを用いた認識を行う
//    }
//
//    // MARK: - Label表示の関数
//    private func addlabel(string: String){
//        // https://qiita.com/k-boy/items/775633fe3fd6da9c5fb6
//        if string == objectLabel.text { return } // tagが同じなら無視する
//        objectLabel.text = string
//    }
//
//    // MARK: - AR文字の関数
//    private func addTag(string: String) {
//
//        // AR文字の座標
//        let infrontOfCamera = SCNVector3(x: 0, y:0.02, z: -0.1)
//
//        // 文字のfont,color,size変更
//        let text = SCNText()
//        text.string = string
//        text.font = UIFont(name: "HiraKakuProN-W6", size: 0.1);
//        let textNode = SCNNode(geometry: text)
//
//        textNode.position = infrontOfCamera
//        sceneView.scene.rootNode.addChildNode(textNode)
//    }
}

extension ARViewController: ARSCNViewDelegate, ARSessionDelegate {
    
}
