//
//  ChallangeView.swift
//  SleuthVision
//
//  Created by mac.bernanda on 27/04/24.
//

import SwiftUI
import AVKit
import Vision

struct ObjectScanView: View {
    @Environment(\.dismiss) var dismiss
    let challenge: Int
    @StateObject var challengeOb = ChallengeObservable()
    @State var showImagePredictionView = false
    @State var _class = ""
    
    var body: some View {
        ZStack() { // Align content to the top-left corner
			
            VideoDetectorView(chal: challenge, challengeOb: challengeOb)
                .ignoresSafeArea()
			VStack {
				HStack (alignment: .top) {
					BackButtonView {
						dismiss()
					}
                    .navigationDestination(isPresented: $showImagePredictionView) {
                        ObjectCaptureView(_class: _class)
                            .navigationBarBackButtonHidden(true)
                    }
					Spacer()
					VStack(alignment: .trailing) {
						ForEach(challengeOb.detectedItemsLabel.filter { $0.value }.keys.sorted(), id: \.self) { key in
							RectangleHints(itemLabel: key, _classBind: $_class, showImagePredict: $showImagePredictionView)
						}

					}
				}
				Spacer()
				ZStack {
					Image("footer")
						.resizable()
						.ignoresSafeArea()
						.aspectRatio(contentMode: .fit)
					HStack {
						ForEach(game0.challenges[challenge].items, id: \.label) { item in
							
							Image(item.isDone ? "\(item.label)-f" : "\(item.label)-s")
								.offset(y: 10)
								.padding(.horizontal, 12)
						}
						
					}.onAppear {
						print(challenge)
					}
				}
//				NavigationLink(
//					destination: ObjectCaptureView(_class: _class).navigationBarBackButtonHidden(true),
//					isActive: $showImagePredictionView,
//					label: {
//						EmptyView() // Use empty view as label
//					})
				/*
				VStack(alignment: .trailing) {
					ForEach(challengeOb.detectedItemsLabel.filter { $0.value }.keys.sorted(), id: \.self) { key in
						RectangleHints(itemLabel: key, _classBind: $_class, showImagePredict: $showImagePredictionView)
					}
				}
				.padding() // Add padding to adjust spacing
				 */
                // on progress mskin ini..
            }
        }
    }
}


#Preview {
	ObjectScanView(challenge: 0)
}
