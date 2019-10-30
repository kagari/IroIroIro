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
    @IBOutlet weak var objectLabel: UILabel!
    
    private var currentBuffer: CVPixelBuffer?
    private let visionQueue = DispatchQueue(label: "com.EnglishApp.pipi")
    private var identifierString = ""
    private var confidence: VNConfidence = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        // TODO: - stringの引数は、QuestionViewから受け取る
        let question_label = make_label(string: "Dog", view: self.view) // お題のラベルを作成
        for elem in question_label {
            self.view.addSubview(elem) // お題のラベルを追加
        }
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
    }
    
    // MARK: - UIを整える関数
    private func setupUI() {
//        objectLabel.text = "を探してね"
//        objectLabel.textColor = .purple
//        objectLabel.textAlignment = .center
//        objectLabel.font = UIFont.systemFont(ofSize: 100.0)
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
    
    // MARK: - カメラからキャプチャしてMLに流す処理群
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
            // YOLOv3読み込み
            let model = try VNCoreMLModel(for: YOLOv3().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            
            // 入力画像を中央の正方形の領域に切り取りる
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
        // 分類
        let classifications = results as! [VNRecognizedObjectObservation]
        
        // 分類した一番いい結果を持ってくる
        if let bestResult = classifications.first(where: { result in result.confidence > 0.5 }),
            let label = bestResult.labels[0].identifier.split(separator: ",").first {
            identifierString = String(label)
            confidence = bestResult.labels[0].confidence
        } else {
            return
        }
        
        print("Class \(identifierString): \(confidence)")
        DispatchQueue.main.async { [weak self] in
            // 認識結果
            self?.addTag(string: self!.identifierString)
            
            // Tagの1文字目を取る
            self?.addlabel(string: String(self!.identifierString.prefix(1)))
        }
    }
    
    // MARK: - Label表示の関数
    private func addlabel(string: String){
        // https://qiita.com/k-boy/items/775633fe3fd6da9c5fb6
        if string == objectLabel.text { return } // tagが同じなら無視する
        objectLabel.text = string
    }

    // MARK: - AR文字の関数
    private func addTag(string: String) {
        
        // AR文字の座標
        let infrontOfCamera = SCNVector3(x: 0, y:0.02, z: -0.1)
        
        // 文字のfont,color,size変更
        let text = SCNText()
        text.string = string
        text.font = UIFont(name: "HiraKakuProN-W6", size: 0.1);
        let textNode = SCNNode(geometry: text)

        textNode.position = infrontOfCamera
        sceneView.scene.rootNode.addChildNode(textNode)
    }
}
