//
//  GameSceneVM.swift
//  SleuthVision
//
//  Created by mac.bernanda on 27/04/24.
//

import Foundation

final class GameSceneVM : ObservableObject {
    @Published var selectedGame : Game
    
    init(gameId: Int) {
        self.selectedGame = games[gameId]
    }
    
}
