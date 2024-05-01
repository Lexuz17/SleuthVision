//
//  Button.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI

struct CaptureButtonView: View {
    var action: () -> Void
    
    var body: some View {
        ButtonView(width: 120, image: "magnifying-glass-alt") {
         action()
        }
    }
}

struct BackButtonView: View {
    var action: () -> Void
    
    var body: some View {
        ButtonView(width: 120, image: "back-button-brown") {
         action()
        }
    }
}

struct ButtonView: View {
    @State var isClick : Bool = false
    var width: CGFloat
    var image: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width)
                
        }
        .padding(12)
        .clipShape(Circle())
        .opacity(isClick ? 0.5 : 1.0)
    }
}
