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
                if let itemLbl = itemLabel, let hints = game0.itemDictionary[itemLbl]?.hints.joined(separator: " ") {
                    Text("\(hints)") // Display the hints
                        .foregroundColor(.white) // Text color
                        .font(.system(size: 100))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10) // Rounded rectangle
                                .foregroundColor(Color.black.opacity(0.5)) // Adjust opacity as needed
                
                        )
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
