//
//  StoryOne.swift
//  SleuthVision
//
//  Created by Gusti Rizky Fajar on 26/04/24.
//

import SwiftUI

struct LocationPoint: View {
    @State var isScaled: Bool = false
    @Binding var locOverlay: CGPoint
    
    var body: some View {
        Image("magnifying-glass-alt")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
            .position(locOverlay)
            .scaleEffect(isScaled ? 1.1 : 1.0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8).repeatForever()) {
                    self.isScaled.toggle()
                }
            }
    }
}

struct StoryOne: View {
    @StateObject var gsvm = GameSceneVM(gameId: 0)
    
    @State private var isTutorialShown: Bool = true
    
    @State private var location: CGPoint = CGPoint(x: 300, y: 200)
    
    @State private var pantryOverlay: CGPoint = CGPoint(x: 350, y: 300)
    @State private var caveOverlay: CGPoint = CGPoint(x: 820, y: 320)
    
    @State private var pantryIsClick = false;
    @State private var caveIsClick = false;
    
    @GestureState private var startTouch: CGPoint? = nil
    
    
    var body: some View {
        NavigationStack {
            OverlayView(showTutorial: $isTutorialShown)
                .background {
                    ZStack {
                        Image("sitemap-brown")
                            .position(location)
                            .gesture(mapGesture)
                            .overlay {
                                if isTutorialShown {
                                    Color.black.opacity(0.7).ignoresSafeArea()
                                }
                            }
                        LocationPoint(locOverlay: $pantryOverlay)
                            .onTapGesture {
                                pantryIsClick = true
                            }
                            .navigationDestination(isPresented: $pantryIsClick) {
                                ObjectScanView(challenge: LocationId.Pantry.rawValue, room: "pantry").navigationBarBackButtonHidden(true)
                            }
                        
                        LocationPoint(locOverlay: $caveOverlay)
                            .onTapGesture {
                                caveIsClick = true
                            }
                            .navigationDestination(isPresented: $caveIsClick) {
                                ObjectScanView(challenge: LocationId.CaveRoom.rawValue, room: "cave").navigationBarBackButtonHidden(true)
                            }
                        
                        //                        Image("magnifying-glass-alt")
                        //                            .resizable()
                        //                            .aspectRatio(contentMode: .fit)
                        //                            .frame(width: 80)
                        //                            .position(caveOverlay)
                        //                            .scaleEffect(isCaveScaled ? 1.1 : 1.0)
                        //                            .onAppear {
                        //                                withAnimation(.easeInOut(duration: 0.8).repeatForever()) {
                        //                                self.isCaveScaled.toggle()
                        //                                }
                        //                            }
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
                Image("hint-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90)
                    .offset(x: -20)
                    .shadow(radius: 10)
                    .onTapGesture {
                        self.showTutorial.toggle()
                    }
                Spacer()
                NavigationLink (destination: CulpritPage().navigationBarBackButtonHidden(true)) {
                    Image("wanted-poster-alt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .offset(x: 30)
                        .shadow(radius: 10)
                }
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
