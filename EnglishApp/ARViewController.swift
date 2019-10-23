//
//  ARViewController.swift
//  EnglishApp
//
//  Created by 大城昂希 on 2019/10/20.
//

import Foundation
import UIKit
import ARKit
import Vision

class ARViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    private var currentBuffer: CVPixelBuffer?
    private let visionQueue = DispatchQueue(label: "com.EnglishApp.pipi")
    private var identifierString = ""
    private var confidence: VNConfidence = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints] // debug用にARの特徴点を出す（黄色い点々）
        
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
    
    // ここでARのカメラからキャプチャした画像を処理する
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
            return
        }
        
        self.currentBuffer = frame.capturedImage
        classifyCurrentImage() // VisionAPIを用いた認識を行う
    }
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // Instantiate the model from its generated Swift class.
            let model = try VNCoreMLModel(for: YOLOv3().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            
            // Crop input images to square area at center, matching the way the ML model was trained.
            request.imageCropAndScaleOption = .centerCrop
            
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    private func classifyCurrentImage() {
        print("classifyCurrentImage!!")
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: currentBuffer!)
        
        visionQueue.async {
            do {
                defer { self.currentBuffer = nil } // この関数を出る時に実行される
                try requestHandler.perform([self.classificationRequest])
            } catch {
                print("Error: Vision request failed with error \"\(error)\"")
            }
        }
    }
    
    private func processClassifications(for request: VNRequest, error: Error?) {
        guard let results = request.results else {
            print("Unable to classify image.\n\(error!.localizedDescription)")
            return
        }
        // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
        let classifications = results as! [VNRecognizedObjectObservation]
        
        // Show a label for the highest-confidence result (but only above a minimum confidence threshold).
        if let bestResult = classifications.first(where: { result in result.confidence > 0.5 }),
            let label = bestResult.labels[0].identifier.split(separator: ",").first {
            identifierString = String(label)
            confidence = bestResult.labels[0].confidence
        } else {
            return
        }
        
        print("Class \(identifierString): \(confidence)")
        DispatchQueue.main.async { [weak self] in
            self?.addTag(string: self!.identifierString)
        }
    }

    private var pre_tag = ""
    private func addTag(string: String) {
        // https://qiita.com/k-boy/items/775633fe3fd6da9c5fb6
        if string == pre_tag { return } // tagが同じなら無視する
        pre_tag = string
        
        // カメラ座標系で30cm前
        let infrontOfCamera = SCNVector3(x: 0, y:0, z: -0.3)
        
        // カメラ座標系 -> ワールド座標系
        guard let cameraNode = sceneView.pointOfView else { return }
        let pointInWorld = cameraNode.convertPosition(infrontOfCamera, to: nil)
        
        let text = SCNText()
        text.string = string
        text.font = UIFont(name: "HiraKakuProN-W6", size: 0.3);
        let textNode = SCNNode(geometry: text)
        
        textNode.position = pointInWorld
        sceneView.scene.rootNode.addChildNode(textNode)
    }
}
