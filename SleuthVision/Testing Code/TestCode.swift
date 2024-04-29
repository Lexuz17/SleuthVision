//
//  TestCode.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 26/04/24.
//
/*
import SwiftUI

struct TestCode: View {
	@State private var location: CGPoint = CGPoint(x: 300, y: 200)
	@GestureState private var fingerTouch: CGPoint? = nil
	@GestureState private var startTouch: CGPoint? = nil
	var body: some View {
		NavigationStack {
			OverlayView()
				.background {
					Image("floor-plan")
						.position(location)
						.gesture(mapDraggable.simultaneously(with: fingerLocation))
			}
		}
    }
	
	var mapDraggable: some Gesture {
		DragGesture()
			.onChanged { value in
				var newTouch = startTouch ?? location
				newTouch.x += value.translation.width
				newTouch.y += value.translation.height
				self.location = newTouch
			}
			.updating($startTouch) { (value, startTouch, transaction) in
				startTouch = startTouch ?? location
			}
	}
	
	var fingerLocation: some Gesture {
		DragGesture()
			.updating($fingerTouch) { (value, fingerTouch, transaction) in
				fingerTouch = value.location
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
					.frame(width: 50)
					.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
					.offset(y: 20)
					.shadow(radius: 2)
			}
			Spacer()
			HStack {
				Image("hint-icon")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 70)
					.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
					.shadow(radius: 2)
			}
		}
	}
}

#Preview {
    TestCode()
}
*/
