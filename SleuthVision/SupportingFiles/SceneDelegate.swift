//
//  SceneDelegate.swift
//  SleuthVision
//
//  Created by Jason Susanto on 01/05/24.
//

import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?
    var gameSceneVM: GameSceneVM?
    
    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession, options
               connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = scene as? UIWindowScene else {return}
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Hello")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Bye")
        let selectedGame = GameSceneVM(gameId: 0).selectedGame
        PlayerManager.shared.saveGame(selectedGame)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Im Back")
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("Im Hiding")
    }
}
