//
//  AppDelegate.swift
//  SleuthVision
//
//  Created by Jason Susanto on 01/05/24.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let gameSafe = PlayerManager.shared.getGame(){
            PlayerManager.shared.resetGamesData()
//            GameSceneVM(gameId: 0).selectedGame.challenges = gameSafe.challenges
//            GameSceneVM(gameId: 0).selectedGame.culprit = gameSafe.culprit
//            GameSceneVM(gameId: 0).selectedGame.id = gameSafe.id
//            GameSceneVM(gameId: 0).selectedGame.story = gameSafe.story
//            GameSceneVM(gameId: 0).selectedGame.title = gameSafe.title
            print("Player terdaftar")
        }
        else {
            print("Player tidak terdaftar")
            let gameTitle = "Case I"
            let scenes = [
                Story(image: "sceneA.jpg", description: ""),
                Story(image: "sceneB.jpg", description: "")
            ]
			let challenges = [
				Challenge(id: LocationId.CaveRoom.rawValue, location: caveRoom, items: caveRoomItems, isDone: false),
				Challenge(id: LocationId.Pantry.rawValue, location: pantry, items: pantryItems, isDone: false)
			]
            let culprit = Culprit(uuid: "cff3e5c5-057d-11ef-86d3-0242ac120002")
            let game0 = Game(id: 0, title: gameTitle, story: scenes, challenges: challenges, culprit: culprit)
            
            // Save game data
            PlayerManager.shared.saveGame(game0)
        }
        return true
    }
	
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfig : UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
