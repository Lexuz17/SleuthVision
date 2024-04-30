//
//  CameraViewController.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import UIKit
import SwiftUI
import AVFoundation
import Vision

protocol CameraViewControllerDelegate: AnyObject {
    func imageCaptured(_ image: UIImage)
}

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    let captureSession = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    private var permissionGranted = false
    private var previewLayer = AVCaptureVideoPreviewLayer()
    private var screenRect: CGRect = UIScreen.main.bounds

    var videoOutput = AVCapturePhotoOutput() 
    
    var bridgingCoordinator: BridgingCoordinator!
    weak var delegate: CameraViewControllerDelegate?

    
    override func viewDidLoad() {
        checkPermission()
        bridgingCoordinator.vc = self
        
        sessionQueue.async { [unowned self] in
            guard permissionGranted else { return }
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopCaptureSession()
    }
    
    func stopCaptureSession() { // <<== Here
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        
        switch UIDevice.current.orientation {
            // Home button on top
        case UIDeviceOrientation.portraitUpsideDown:
            self.previewLayer.connection?.videoOrientation = .portraitUpsideDown
            
            // Home button on right
        case UIDeviceOrientation.landscapeLeft:
            self.previewLayer.connection?.videoOrientation = .landscapeRight
            
            // Home button on left
        case UIDeviceOrientation.landscapeRight:
            self.previewLayer.connection?.videoOrientation = .landscapeLeft
            
            // Home button at bottom
        case UIDeviceOrientation.portrait:
            self.previewLayer.connection?.videoOrientation = .portrait
            
        default:
            break
        }
    }
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: permissionGranted = true
        case .notDetermined: requestPermission()
        default: permissionGranted = false
        }
    }
    
    func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }
    
    func setupCaptureSession() {
        guard let videoDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        guard captureSession.canAddOutput(videoOutput) else { return }
        captureSession.addOutput(videoOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
        previewLayer.connection?.videoOrientation = .landscapeRight
        videoOutput.connection(with: .video)?.videoOrientation = .landscapeRight
        
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.addSublayer(self!.previewLayer)
        }
    }
}
