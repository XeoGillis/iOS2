//
//  Game.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation

struct Game {
    private(set) var players: Array<Player>
    
    init(arrayOfPresentPlayers: Array<Int>) {
        players = Array<Player>()
        for number in arrayOfPresentPlayers {
            switch (number) {
            case 1: players.append(Player(position: [2, 5], content: "Sophie", id: number))
            case 2: players.append(Player(position: [2, 5, 4, 3, 6], content: "Romanie", id: number))
            case 3: players.append(Player(position: [1], content: "Lieselotte", id: number))
            case 4: players.append(Player(position: [3, 6], content: "Manon", id: number))
            case 5: players.append(Player(position: [2, 5, 3, 6], content: "Lindsey", id: number))
            case 6: players.append(Player(position: [3, 6], content: "Lieze", id: number))
            case 7: players.append(Player(position: [2, 5, 3, 6, 4], content: "Leontien", id: number))
            case 8: players.append(Player(position: [2, 5, 4], content: "Lien", id: number))
            case 10: players.append(Player(position: [2, 5, 4], content: "Remie", id: number))
            case 11: players.append(Player(position: [2, 5, 4], content: "Merel", id: number))
            case 12: players.append(Player(position: [2, 5, 3, 6, 4], content: "Laura", id: number))
            case 14: players.append(Player(position: [2, 5, 1, 4], content: "Elke", id: number))
            case 15: players.append(Player(position: [1], content: "Luka", id: number))
            case 17: players.append(Player(position: [7], content: "Romanie", id: number))
            default: players.append(Player(position: [7], content: "Anoniem", id: number))
            }
        }
    }
    
    mutating func choosePosition(_ namedPosition : Int) {
        for var player in players {
            player.isFaceUp = false
        }
        let suitablePlayers = players.filter { $0.position.contains(namedPosition) }
        for var player in suitablePlayers {
            player.isFaceUp = true
            print(player.content)
        }
    }
    
    struct Player: Identifiable {
        var isFaceUp: Bool = false
        var isAlreadyChosen: Bool = false
        var position: Array<Int>
        var content: String
        var id: Int
    }
}

