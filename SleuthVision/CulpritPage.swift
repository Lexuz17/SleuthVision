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
                Image("culprit-frame")
					.resizable()
					.aspectRatio(contentMode: .fit)

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
				}
			}
		}
    }
}

#Preview {
    CulpritPage()
}
