//
//  TutorialPage.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 29/04/24.
//

import SwiftUI

struct TutorialPage: View {
	@State private var isTapping: Bool = false
	var body: some View {
		NavigationStack {
			NavigationLink (destination: StoryOne().navigationBarBackButtonHidden(true)) {
				ZStack {
					Image("story-background")
						.resizable()
						.ignoresSafeArea()
					VStack {
						Image("book-tutorial")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
					}
					VStack {
						Spacer()
						HStack {
							Spacer()
							Image("tap-gesture")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 100)
								.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
								.rotationEffect(.degrees(isTapping ? -25 : 0))
								.onAppear {
									withAnimation(.linear(duration: 1).speed(2).repeatForever(autoreverses: true)) {
										self.isTapping.toggle()
									}
							}
						}
					}
										
				}
			}
			.buttonStyle(PlainButtonStyle())
		}
	}
}

#Preview {
	TutorialPage()
}
