//
//  SleuthVisionApp.swift
//  SleuthVision
//
//  Created by Jason Susanto on 26/04/24.
//

import SwiftUI

@main
struct SleuthVisionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            StoryOne()
        }
    }
}
