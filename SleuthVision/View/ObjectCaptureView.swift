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
    @StateObject var gsvm = GameSceneVM(gameId: 0)
	@State private var capturedImage: UIImage?
	@State private var predictionState : PredictionState = .notCaptured
	
	private var captureButtonImage: String = "magnifying-glass-alt"
	
    init(_class : String){
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
                                    gsvm.selectedGame.updateItemStatus(itemFound: _class, isFound: true)
                                    gsvm.selectedGame.UpdateChallenges()
                                    gsvm.selectedGame.printAllChallenges()
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
					.offset(x: 25, y: -10)
			case .wrong:
				Image(systemName: "x.circle")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 200)
					.foregroundStyle(Color.red)
					.offset(x: 25, y: -10)
			}
			Image("object-capture")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.ignoresSafeArea()
			HStack {
				VStack {
					BackButtonView {
						dismiss()
					}
					Spacer()
				}
				Spacer()
				CaptureButtonView(buttonImage: captureButtonImage) {
					coordinator.vc.takePicture()
					predictionState = .processed
				}
				.offset(x: 20)
			}
		}
	}
}

//#Preview {
//	ObjectCaptureView(_class: "coffeMachine")
//}

