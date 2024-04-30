//
//  CulpritCaptureView.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI

struct CulpritCaptureView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var coordinator: BridgingCoordinator
    @State private var predictionState: PredictionState = .notCaptured
    
    init() {
        let coordinator = BridgingCoordinator()
        self._coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        ZStack {
            CameraView(bridgingCoordinator: coordinator) { image in
                
                if let img = image {
                    
                    ImageRecognizer(apiToken: "").recognizeImage(image: img) { result in
                        switch result {
                        case .success(let prediction):
                            predictionState = .correct
                            print("Recognition: \(prediction)")
                            // Handle successful prediction
                        case .failure(let error):
                            predictionState = .wrong
                            print("Error: \(error.localizedDescription)")
                            // Handle error
                        }
                    }
                    
                }
            }.ignoresSafeArea(.all, edges: .all)
            
            
            HStack {
                BackButtonView {
                    dismiss()
                }
                
                Spacer()
                
                CaptureButtonView {
                    coordinator.vc.takePicture()
                    predictionState = .processed
                }
            }
            
            switch predictionState {
            case .notCaptured:
                Text("Wait for capture image")
            case .processed:
                Text("Still processing")
            case .correct:
                Text("Correct")
            case .wrong:
                Text("Wrong")
            }
        }
    }
}
