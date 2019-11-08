import Foundation
import ARKit
import Vision

protocol ObjectDetectionModelDelegate: class {
    func detectionFinished(identifier: String?, objectBounds: CGRect?)
}


class ObjectDetectionModel: NSObject {
    
    var delegate: ObjectDetectionModelDelegate?
    private var currentBuffer: CVPixelBuffer?
    private var bounds: CGSize?
    private var objectBounds: CGRect?
    private var identifier: String?
    private var confidence: VNConfidence?
    private let visionQueue: DispatchQueue
    
    override init() {
        visionQueue = DispatchQueue(label: "com.EnglishApp.pipi")
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
    
    func classifyCurrentImage(frame: ARFrame, bounds: CGSize?) {
        guard self.currentBuffer == nil, case .normal = frame.camera.trackingState else {
            return
        }
        
        self.currentBuffer = frame.capturedImage
        self.bounds = bounds
        
       print("classifyCurrentImage!!")
       
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: self.currentBuffer!)
       
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
            self.identifier = String(label)
            self.confidence = bestResult.labels[0].confidence
            self.objectBounds = VNImageRectForNormalizedRect(bestResult.boundingBox, Int(self.bounds!.width), Int(self.bounds!.height))
        } else {
            return
        }
        
        DispatchQueue.main.async {() in
            // 認識したことをdelegateを通してARViewControllerに通知する
            print("識別結果 -> \(String(describing: self.identifier)): \(String(describing: self.confidence))")
            print("Rectangle -> width: \(String(describing: self.objectBounds?.width)), height: \(String(describing: self.objectBounds?.height))")
            self.delegate?.detectionFinished(identifier: self.identifier, objectBounds: self.objectBounds)
        }
    }
}

extension ObjectDetectionModel: ObjectDetectionModelDataSource {
    var identifierString: String? {
        return self.identifier
    }
}
