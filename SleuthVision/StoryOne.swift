//
//  StoryOne.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 26/04/24.
//

import SwiftUI

struct StoryOne: View {
	@Environment(\.dismiss) var dismiss
    var body: some View {
		NavigationStack {
			ZStack {
				VStack {
					HStack {
						Button(action: {
							dismiss()
						}) {
							Image(systemName: "chevron.left.circle")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.foregroundStyle(Color("brown-two"))
								.frame(width: 45, height: 45)
								.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
								.offset(y: 20)
								.shadow(radius: 2)
						}
						Image("wanted-poster")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 55)
							.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
							.offset(y: 20)
							.shadow(radius: 2)
					}
					Spacer()
					HStack {
						Image("vecteezy_hand-holding-phone-taking-mobile-photo-making-photograph_28887339")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 70)
							.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
							.shadow(radius: 2)
					}
				}
			}
		}
    }
}

#Preview {
    StoryOne()
}
