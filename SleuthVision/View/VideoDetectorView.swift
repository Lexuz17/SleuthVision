//
//  ObjectScanView2.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI

struct VideoDetectorView: UIViewControllerRepresentable {
    var chal : Int
    var challengeOb : ChallengeObservable
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = VideoDetectorController()
        controller.challengeID = chal
        controller.coordinator = VideoDetectorCoordinator(challengeOb: challengeOb)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

