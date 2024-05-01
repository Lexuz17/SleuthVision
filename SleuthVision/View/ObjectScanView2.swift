//
//  ObjectScanView.swift
//  SleuthVision
//
//  Created by mac.bernanda on 29/04/24.
//

import SwiftUI

struct ObjectScanView2: View {
    let challenge: Int
    @StateObject var challengeOb = ChallengeObservable()
    @State var toObjectCapture = false
    @State var _class = ""
    var room: String
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VideoDetectorView(chal: challenge, challengeOb: challengeOb)
                    .ignoresSafeArea()
                
                VStack(alignment: .trailing) {
                    ForEach(challengeOb.detectedItemsLabel.filter { $0.value }.keys.sorted(), id: \.self) { key in
                        RectangleHints(itemLabel: key, _classBind: $_class, showImagePredict: $toObjectCapture)
                    }
                }
                .padding() // Add padding to adjust spacing
                
            }.navigationDestination(isPresented: $toObjectCapture) {
                ObjectCaptureView(_class: _class, room: room)
                    .navigationBarBackButtonHidden(true)
            }
        }
        
    }
}


