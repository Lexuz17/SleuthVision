//
//  AppDelegate.swift
//  SleuthVision
//
//  Created by Jason Susanto on 01/05/24.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let playerSafe = PlayerManager.shared.getPlayer(){
            print(playerSafe.name)
            PlayerManager.shared.setPlayerNow(playerSafe)
            print("Player terdaftar")
//            PlayerManager.shared.resetPlayer()
        }
        else {
            print("Player tidak terdaftar")
//            let newPlayer = Player(
//                name: "Haerin",
//                roomProgress: [1: .completed, 2: .inProgress, 3: .notStarted],
//                completedTasksPerRoom: [1: 3, 2: 2],
//                tasksDone: [1, 2, 3, 4, 5]
//            )
//            PlayerManager.shared.setPlayerNow(newPlayer)
        }
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfig : UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
