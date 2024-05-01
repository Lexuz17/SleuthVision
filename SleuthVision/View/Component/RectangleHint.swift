//
//  RectangleHint.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI

struct RectangleHints: View {
    let itemLabel: String?
    @State private var isButtonClicked = false
    @State private var isTextVisible = false
    
    @Binding var _classBind : String
    @Binding var showImagePredict : Bool
    
    var body: some View {
        HStack {
            if isTextVisible {
                if let itemLbl = itemLabel, let hints = game0.itemDictionary[itemLbl]?.hints {
                    
					HintsView(hints: hints)
					
                }
            }
            
            CaptureButtonView {
                isButtonClicked.toggle()
                showImagePredict.toggle()
                if let itemLbl = itemLabel, let _class = game0.itemDictionary[itemLbl]?._class {
                    _classBind = _class
                }
			}
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) { // Apply animation 
                isTextVisible = true // Set text visibility to true
            }
        }
    }
}

struct HintsView: View {
	var hints: [String]
	
	var body: some View {
		ZStack {
			Image("hints_holder")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 188)
			
			HStack (spacing: 18) {
				ForEach(hints, id: \.self) { hint in
					Text("\(hint)") // Display the hints
						.foregroundColor(.white) // Text color
						.font(.system(size: 30))
						.frame(width: 32.6)
						.padding(.horizontal, 1)
				}
			}
			
		}
	}
}

#Preview {
	VStack {
		HStack {
			HintsView(hints: ["🧑‍💻", "z", "😙"])
			Text("Tes")
		}
		
		HStack {
			HintsView(hints: ["🧑‍💻", "", "🇮🇩"])
			Text("Tes")
		}
	}
	
}
