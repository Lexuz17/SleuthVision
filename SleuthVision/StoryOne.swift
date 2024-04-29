//
//  StoryOne.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 26/04/24.
//

import SwiftUI

struct StoryOne: View {
	@State private var isTutorialShown = false
	@State private var isPantryScaled: Bool = false
	@State private var isCaveScaled: Bool = false
	@State private var location: CGPoint = CGPoint(x: 300, y: 200)
	@State private var pantryOverlay: CGPoint = CGPoint(x: 350, y: 300)
	@State private var caveOverlay: CGPoint = CGPoint(x: 820, y: 320)
	@GestureState private var startTouch: CGPoint? = nil
	var body: some View {
		NavigationStack {
			OverlayView(showTutorial: $isTutorialShown)
				.background {
					ZStack {
						Image("sitemap-brown")
							.position(location)
							.gesture(mapGesture)
						Image("magnifying-glass-alt")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 80)
							.position(pantryOverlay)
							.scaleEffect(isPantryScaled ? 1.1 : 1.0)
							.onAppear {
								withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
									self.isPantryScaled.toggle()
								}
							}
						Image("magnifying-glass-alt")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 80)
							.position(caveOverlay)
							.scaleEffect(isCaveScaled ? 1.1 : 1.0)
							.onAppear {
								withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
								self.isCaveScaled.toggle()
								}
							}
					}
				}
				.overlay {
					if isTutorialShown {
						showTutorialView()
					}
				}
		}
	}
	
	var mapGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				var newTouch = startTouch ?? location
				newTouch.x += value.translation.width
				newTouch.y += value.translation.height
				self.location = newTouch
				self.pantryOverlay = CGPoint(x: newTouch.x + 50, y: newTouch.y + 100)
				self.caveOverlay = CGPoint(x: newTouch.x + 520, y: newTouch.y + 120)
			}
			.updating($startTouch) { (value, startTouch, transaction) in
				startTouch = startTouch ?? location
			}
	}
}

struct OverlayView: View {
	@Binding var showTutorial: Bool
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					self.showTutorial.toggle()
				}) {
					Image("hint-icon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 90)
						.offset(x: -20)
						.shadow(radius: 10)
				}
				.buttonStyle(PlainButtonStyle())
				Spacer()
				Image("wanted-poster-alt")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 120)
					.offset(x: 30)
					.shadow(radius: 10)
			}
			Spacer()
		}
	}
}

struct showTutorialView: View {
	var body: some View {
		VStack {
			Image("book-tutorial")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
		}
	}
}

#Preview {
    StoryOne()
}
