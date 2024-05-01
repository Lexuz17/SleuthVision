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
	
	private var captureButtonImage: String = "camera-alt"
    
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
            
			Image("camera-capture")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 630)
				.offset(x: 10, y: 10)
			
            HStack {
				VStack {
					BackButtonView {
						dismiss()
					}
					.frame(width: 50)
					Spacer()
				}
                
                Spacer()
                
				VStack {
					/*
					Image("culprit-photo")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.offset(x: 20, y: 20)
						.frame(width: 150)
					*/
					Spacer()
					CaptureButtonView(buttonImage: captureButtonImage) {
						coordinator.vc.takePicture()
						predictionState = .processed
					}
					.offset(x: 60)
					Spacer()
				}
            }
            
            switch predictionState {
            case .notCaptured:
                Text("")
            case .processed:
                Text("")
            case .correct:
				Image(systemName: "checkmark.circle")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 200)
					.foregroundStyle(Color.green)
					.offset(x: -20, y: 30)
            case .wrong:
				Image(systemName: "x.circle")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 200)
					.foregroundStyle(Color.red)
					.offset(x: -30, y: 40)
            }
        }
    }
}

#Preview {
	CulpritCaptureView()
}
