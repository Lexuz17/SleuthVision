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
    var playerNow: Player?
    
    func savePlayer(_ player: Player) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(player)
            userDefaults.set(encodedData, forKey: playerKey)
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
        userDefaults.reset()
    }
}

extension UserDefaults{
    func reset() {
        removeObject(forKey: "PlayerData")
    }
}
