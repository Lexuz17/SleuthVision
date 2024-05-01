//
//  SceneDelegate.swift
//  SleuthVision
//
//  Created by Jason Susanto on 01/05/24.
//

import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession, options
               connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = scene as? UIWindowScene else {return}
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Hello")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Im Hiding")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Im Back")
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
//        if let player = PlayerManager.shared.getPlayerNow() {
//            PlayerManager.shared.savePlayer(player)
//        }
//        PlayerManager.shared.resetPlayer()
        PlayerManager.shared.setPlayerNow(Player(name: "Yeji"))
        print(PlayerManager.shared.getPlayerNow()?.name)
        print("Bye")
    }
}
