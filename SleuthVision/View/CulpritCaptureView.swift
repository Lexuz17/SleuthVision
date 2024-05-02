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
	
	private var captureButtonImage: String = "capture-button"
    
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
            
			Image("camera-screen")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.ignoresSafeArea()
			
            VStack {
				HStack {
					BackButtonView {
						dismiss()
					}
					.frame(width: 50)
					Spacer()
				}
                
                Spacer()
                
				VStack {
					HStack {
						//					Image("culprit-photo")
						//						.resizable()
						//						.aspectRatio(contentMode: .fit)
						//						.offset(x: 20, y: 20)
						//						.frame(width: 150)
						Spacer()
						CaptureButtonView(buttonImage: captureButtonImage) {
							coordinator.vc.takePicture()
							predictionState = .processed
						}
						.offset(x: -105, y: -30)
						//					Spacer()
					}
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
					.offset(x: -75, y: 70)
            case .wrong:
				Image(systemName: "x.circle")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 200)
					.foregroundStyle(Color.red)
					.offset(x: -75, y: 70)
            }
        }
    }
}

#Preview {
	CulpritCaptureView()
}
