//
//  CameraView.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI
import AVFoundation


class BridgingCoordinator: ObservableObject {
    var vc: CameraViewController!
}

struct CameraView: UIViewControllerRepresentable {
    var bridgingCoordinator: BridgingCoordinator
    let onCapture: (UIImage?) -> Void
    
    func makeCoordinator() -> CameraCoordinator {
        return CameraCoordinator(self, onCapture: onCapture)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let cameraController = CameraViewController()
        cameraController.bridgingCoordinator = bridgingCoordinator
        cameraController.delegate = context.coordinator
        return cameraController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    class CameraCoordinator: NSObject, CameraViewControllerDelegate {
        let parent: CameraView
        let onCapture: (UIImage?) -> Void

        
        init(_ view: CameraView, onCapture: @escaping (UIImage?) -> Void) {
            self.parent = view
            self.onCapture = onCapture
        }
        
        func imageCaptured(_ image: UIImage) {
            onCapture(image)
        }
    }
}


//
//struct BadCameraPreview: UIViewRepresentable {
//    @ObservedObject var cameraCapture : CameraCaptureManager
//
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
//        cameraCapture.previewLayer = AVCaptureVideoPreviewLayer(session: cameraCapture.session)
//
//        cameraCapture.previewLayer.frame = view.frame
//        cameraCapture.previewLayer.videoGravity = .resizeAspectFill
//        cameraCapture.previewLayer.connection?.videoOrientation = .landscapeRight
//
//        view.layer.addSublayer(cameraCapture.previewLayer)
//
//        DispatchQueue.global().async {
//            cameraCapture.previewLayer.session?.startRunning()
//        }
//
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}
