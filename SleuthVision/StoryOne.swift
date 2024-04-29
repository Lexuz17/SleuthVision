//
//  StoryOne.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 26/04/24.
//

import SwiftUI

struct StoryOne: View {
	@State private var isPantryScaled: Bool = false
	@State private var isCaveScaled: Bool = false
	@State private var location: CGPoint = CGPoint(x: 300, y: 200)
	@State private var pantryOverlay: CGPoint = CGPoint(x: 350, y: 300)
	@State private var caveOverlay: CGPoint = CGPoint(x: 820, y: 320)
	@GestureState private var startTouch: CGPoint? = nil
	var body: some View {
		NavigationStack {
			OverlayView()
				.background {
					ZStack {
						Image("sitemap-brown")
							.position(location)
							.gesture(mapGesture)
						ZStack {
							Image("barrel")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50)
								.position(pantryOverlay)
							Text("0/0")
								.position(pantryOverlay)
						}
						.scaleEffect(isPantryScaled ? 1.1 : 1.0)
						.onAppear {
							withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
								self.isPantryScaled.toggle()
							}
						}
						ZStack {
							Image("barrel")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 50)
								.position(caveOverlay)
							Text("0/0")
								.position(caveOverlay)
						}
						.scaleEffect(isCaveScaled ? 1.1 : 1.0)
						.onAppear {
							withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
								self.isCaveScaled.toggle()
							}
						}
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
	@Environment(\.dismiss) var dismiss
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					dismiss()
				}) {
					Image("back-button-brown")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.foregroundStyle(Color("brown-two"))
						.frame(width: 100, height: 100)
						.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
						.offset(y: 20)
						.shadow(radius: 10)
				}
				Image("wanted-poster")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 50)
					.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
					.offset(y: 20)
					.shadow(radius: 10)
			}
			Spacer()
			HStack {
				Image("hint-icon")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 90)
					.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
					.shadow(radius: 10)
			}
		}
	}
}


#Preview {
    StoryOne()
}
