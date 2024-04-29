//
//  SwiftUIView.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 26/04/24.
//

import SwiftUI

struct SwiftUIView: View {
	var body: some View {
		NavigationStack {
			ZStack {
//				Color("brown-two")
//					.ignoresSafeArea()
				Image("story-background")
					.resizable()
					.ignoresSafeArea()
				VStack (alignment: .leading) {
					ScrollView (.horizontal, showsIndicators: false) {
						HStack {
							NavigationLink (destination: StoryOne().navigationBarBackButtonHidden(true)) {
								Image("lab-one")
									.resizable()
									.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
									.frame(width: 250, height: 250, alignment: .center)
									.clipped()
									.clipShape(RoundedRectangle(cornerRadius: 25.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
									.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
									.overlay(content: {
										Image("magnifying-glass-alt")
											.resizable()
											.aspectRatio(contentMode: .fill)
											.frame(width: 150, height: 150)
											.offset(y: -90)
											.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
									})
									.scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .horizontal) { effect, phase in effect
											.scaleEffect(1 - abs(phase.value))
											.opacity(1 - abs(phase.value))
											.rotation3DEffect(.degrees(phase.value * 90), axis: (x: 0, y: -1, z: 0))
								}
							}
							ForEach(0 ..< 3) { item in
								RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
									.frame(width: 250, height: 250)
									.foregroundStyle(Color("brown-two"))
									.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
									.overlay(content: {
										Image("question-mark")
											.resizable()
											.aspectRatio(contentMode: .fill)
											.frame(width: 150, height: 150)
											.offset(y: -90)
											.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
									})
									.scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .horizontal) { effect, phase in effect
											.scaleEffect(1 - abs(phase.value))
											.opacity(1 - abs(phase.value))
											.rotation3DEffect(.degrees(phase.value * 90), axis: (x: 0, y: -1, z: 0))
								}
							}
						}
					}
					.scrollClipDisabled()
					.safeAreaPadding(.horizontal, 10)
					.scrollTargetBehavior(.viewAligned)
				}
			}
//			.background {
//				Image("background-story")
//					.resizable()
//					.ignoresSafeArea()
//			}
		}
	}
}

#Preview {
    SwiftUIView()
}
