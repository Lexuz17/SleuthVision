//
//  TutorialPage.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 29/04/24.
//

import SwiftUI

struct TutorialPage: View {
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
					Image("touch-icon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 100)
						.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomTrailing)
						.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
				}
			}
			.buttonStyle(PlainButtonStyle())
		}
    }
}

#Preview {
    TutorialPage()
}
