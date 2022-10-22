//
//  VolleyballGame.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation
class VolleyballGame: ObservableObject {
    static let players = [1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 17]
    static let positions = [4, 3, 2, 5, 6, 1, 7]
    var position = 0

    static func createGame() -> Game {
        Game(arrayOfPresentPlayers: players, arrayOfPossiblePositions: positions)
    }

    @Published private var model: Game = createGame()
        
    var players: Array<Game.Player> {
        model.players
    }
    
    var positions: Array<Game.Position> {
        model.positions
    }
    
    // MARK - Intent(s)
    func choosePosition(_ namedPosition : Int) {
        position = namedPosition
        model.choosePosition(namedPosition)
    }
    
    func choosePlayer(_ namedPlayer: Int) {
        model.choosePlayer(namedPlayer, at: position)
    }
    
    func cancelSetUp() {
        model.cancelSetUp()
    }
    
    func saveSetUp() {
        model.saveSetUp()
    }
}
