//
//  CulpritPage.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 29/04/24.
//

import SwiftUI

struct CulpritPage: View {
	@Environment(\.dismiss) var dismiss
	var body: some View {
		NavigationStack {
			ZStack {
				Image("story-background")
					.resizable()
					.ignoresSafeArea()
				ZStack {
					Image("culprit-frame")
						.resizable()
						.frame(width: 275, height: 320)
					Image(game0.getCulpritImageRepresentation())
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 200)
					if game0.getGameCompletion() {
						Image("handcuff")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 300)
							.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
					}
				}
				VStack {
					HStack {
						Image("back-button-brown")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 80)
							.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
							.onTapGesture {
								dismiss()
							}
						Spacer()
					}
					Spacer()
					
					HStack {
						Spacer()
						NavigationLink (destination: CulpritCaptureView().navigationBarBackButtonHidden(true)) {
							Image("camera-alt")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 120)
								.shadow(radius: 10)
						}
					}
					Spacer()
					
					if game0.getGameCompletion() {
						HStack {
							Image("reset-button")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 80)
								.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
								.onTapGesture {
									PlayerManager.shared.resetGamesData()
									game0.resetGame()
									dismiss()
								}
							Spacer()
						}
					}
					
				}
			}
		}
	}
}

#Preview {
    CulpritPage()
}
