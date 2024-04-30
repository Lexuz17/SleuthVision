//
//  ObjectCaptureView.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI

struct ObjectCaptureView: View {
    var _class : String
    @Environment(\.dismiss) var dismiss
    @StateObject private var coordinator: BridgingCoordinator
    @State private var capturedImage: UIImage?
    @State private var predictionState : PredictionState = .notCaptured
    
    init(_class : String) {
        let coordinator = BridgingCoordinator()
        self._coordinator = StateObject(wrappedValue: coordinator)
        self._class = _class
    }
    
    var body: some View {
        ZStack {
            CameraView(bridgingCoordinator: coordinator) { image in
                
                if let img = image {
                    do {
                        try ImagePredictor().makePredictions(for: img) { predictions in
                            
                            if let firstPrediction = predictions?.first {
                                print("Prediction \(firstPrediction.classification)")
                                
                                if firstPrediction.classification == _class {
                                    self.predictionState = .correct
                                } else {
                                    self.predictionState = .wrong
                                }
                            }
                        }
                    } catch {
                        print("Error predicting image: \(error.localizedDescription)")
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
    
    //    }.onChange(of: capturedImage){
    //        print(capturedImage?.heicData()  ?? "KK")
    //        openResult = true
    //    }.sheet(isPresented: $openResult){
    //        if let capturedImage = capturedImage { // Checking if there's a captured image
    //            Image(uiImage: capturedImage)
    //                .resizable()
    //                .aspectRatio(contentMode: .fill)
    //                .edgesIgnoringSafeArea(.all)
    //        } else {
    //            Text("No image captured") // Show a placeholder if no image is captured
    //        }
    
    
}
