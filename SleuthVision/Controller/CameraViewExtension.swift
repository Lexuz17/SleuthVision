//
//  CameraViewController+Take.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import AVFoundation
import UIKit

extension CameraViewController {
    func takePicture() {
        let photoSettings = AVCapturePhotoSettings()
        self.videoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        self.stopCaptureSession()
        
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else {
            print("Error converting photo to image")
            return
        }
        
        delegate?.imageCaptured(image)
    }
}
