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
				VStack {
					HStack {
						Image("back-button-brown")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
							.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
							.onTapGesture {
								dismiss()
							}
						Spacer()
					}
					Spacer()
					HStack {
						Spacer()
						Image("camera")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 120)
							.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
					}
				}
			}
		}
    }
}

#Preview {
    CulpritPage()
}
