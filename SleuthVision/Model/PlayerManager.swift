//
//  PlayerManager.swift
//  SleuthVision
//
//  Created by Jason Susanto on 01/05/24.
//

import Foundation

class PlayerManager: ObservableObject {
    static let shared = PlayerManager()
    private let userDefaults = UserDefaults.standard
    private let playerKey = "PlayerData"
    @Published var playerNow: Player?
    
    init() {
        self.playerNow = getPlayer()
    }
    
    func savePlayer(_ player: Player) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(player)
            userDefaults.set(encodedData, forKey: playerKey)
            self.playerNow = player
        } catch {
            print("Failed to save player data: \(error)")
        }
    }
    
    func getPlayer() -> Player? {
        if let savedData = userDefaults.data(forKey: playerKey) {
            do {
                let decoder = JSONDecoder()
                let player = try decoder.decode(Player.self, from: savedData)
                return player
            } catch {
                print("Failed to decode player data: \(error)")
            }
        }
        return nil
    }
    
    func getPlayerNow() -> Player? {
        return playerNow
    }
    
    func setPlayerNow(_ player: Player?) {
        if let player = player {
            self.playerNow = player
        } else {
            self.playerNow = nil
        }
    }
    
    func resetPlayer(){
        userDefaults.resetPlayer()
    }
    
    func resetGamesData(){
        userDefaults.resetGameData()
    }
    
    func saveGame(_ game: Game) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(game)
            userDefaults.set(encodedData, forKey: "GameData")
        } catch {
            print("Failed to save game data: \(error)")
        }
    }
    
    // Method to retrieve the Game object
    func getGame() -> Game? {
        if let savedData = userDefaults.data(forKey: "GameData") {
            do {
                let decoder = JSONDecoder()
                let game = try decoder.decode(Game.self, from: savedData)
                return game
            } catch {
                print("Failed to decode game data: \(error)")
            }
        }
        return nil
    }

}

extension UserDefaults{
    func resetPlayer() {
        removeObject(forKey: "PlayerData")
    }
    
    func resetGameData() {
        removeObject(forKey: "GameData")
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
}
