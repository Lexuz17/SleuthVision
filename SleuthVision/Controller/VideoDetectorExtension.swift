import Vision
import AVFoundation
import UIKit

extension VideoDetectorController {
    func setupDetector() {
        do {
            let model = try yolov9c().model
            let visionModel = try VNCoreMLModel(for: model)
            let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
            self.requests = [recognitions]
        } catch let error {
            print(error)
        }
    }
    
    func detectionDidComplete(request: VNRequest, error: Error?) {
        DispatchQueue.main.async(execute: {
            if let results = request.results {
                self.extractDetections(results)
            }
        })
    }
    
    func extractDetections(_ results: [VNObservation]) {
        detectionLayer.sublayers = nil
        coordinator?.challengeOb?.resetDetectedItems()
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
        
            
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(screenRect.size.width), Int(screenRect.size.height))
            
            let transformedBounds = CGRect(x: objectBounds.minX, y: screenRect.size.height - objectBounds.maxY, width: objectBounds.maxX - objectBounds.minX, height: objectBounds.maxY - objectBounds.minY)
            
            
            if let objectLabel = objectObservation.labels.first?.identifier as? String {
                if let chalId = challengeID {
                    if (objectObservation.confidence < 0.43 || !game0.getItemList(locationId: chalId).contains([objectLabel])){
                        return
                    }
                }
                
                coordinator?.challengeOb?.detectedItemsLabel[objectLabel] = true
                
                let boxLayer = self.drawBoundingBox(bounds: transformedBounds, label: objectLabel)
                detectionLayer.addSublayer(boxLayer)
            }
            
        }
    }

    
    func setupLayers() {
        detectionLayer = CALayer()
        detectionLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.addSublayer(self!.detectionLayer)
        }
    }
    
    func updateLayers() {
        detectionLayer?.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
    }
    
    func drawBoundingBox(bounds: CGRect, label: String) -> CALayer {
        let boxLayer = CALayer()
        boxLayer.frame = bounds
        boxLayer.borderWidth = 3.0
        boxLayer.borderColor = CGColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        boxLayer.cornerRadius = 4
        
        return boxLayer
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:]) // Create handler to perform request on the buffer
        
        do {
            try imageRequestHandler.perform(self.requests) // Schedules vision requests to be performed
        } catch {
            print(error)
        }
    }
}
