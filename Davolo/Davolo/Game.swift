//
//  Game.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation
import MessageUI

struct Game {
    private(set) var players: Array<Player>
    private(set) var positions: Array<Position>
    
    init(arrayOfPresentPlayers: Array<Int>, arrayOfPossiblePositions: Array<Int>) {
        players = Array<Player>()
        positions = Array<Position>()
        for id in arrayOfPossiblePositions {
            positions.append(Position(id: id, content: String(id)))
        }
        for number in arrayOfPresentPlayers.sorted() {
            switch (number) {
            case 1: players.append(Player(position: [2, 5], content: "Sophie", id: number))
            case 2: players.append(Player(position: [7], content: "Elke", id: number))
            case 3: players.append(Player(position: [1], content: "Lieselotte", id: number))
            case 4: players.append(Player(position: [3, 6], content: "Manon", id: number))
            case 5: players.append(Player(position: [2, 5, 3, 6], content: "Lindsey", id: number))
            case 6: players.append(Player(position: [3, 6], content: "Lieze", id: number))
            case 7: players.append(Player(position: [2, 5, 3, 6, 4], content: "Leontien", id: number))
            case 8: players.append(Player(position: [2, 5, 4], content: "Lien", id: number))
            case 10: players.append(Player(position: [2, 5, 4], content: "Remie", id: number))
            case 11: players.append(Player(position: [2, 5, 4], content: "Merel", id: number))
            case 12: players.append(Player(position: [2, 5, 3, 6, 4], content: "Laura", id: number))
            case 14: players.append(Player(position: [2, 5, 1, 4], content: "Elke (l)", id: number))
            case 15: players.append(Player(position: [1], content: "Luka", id: number))
            case 17: players.append(Player(position: [7], content: "Romanie (l)", id: number))
            default: print("Error in given player: " + String(number))
            }
        }
    }
    
    mutating func choosePosition(_ namedPosition : Int) {
        for index in players.indices {
            let suitable = players[index].position.contains(namedPosition) && !players[index].isAlreadyChosen
            players[index].isFaceUp = suitable
            
        }
    }
    
    mutating func choosePlayer(_ namedPlayer : Int, at namedPosition : Int) {
        for index in positions.indices {
            if positions[index].id == namedPosition {
                if positions[index].isFilledIn == true {
                    editPlayer(index, at: namedPosition)
                }
                positions[index].isFilledIn = true
                positions[index].player = namedPlayer
            }
        }
        for index in players.indices {
            if players[index].id == namedPlayer {
                players[index].isAlreadyChosen = true
            }
            players[index].isFaceUp = false
        }
    }
    
    mutating func editPlayer(_ indexPlayer : Int, at namedPosition : Int) {
        for index in players.indices {
            if players[index].id == positions[indexPlayer].player {
                players[index].isAlreadyChosen = false
            }
        }
    }
    
    mutating func cancelSetUp() {
        for index in positions.indices {
            positions[index].isFilledIn = false
        }
        for index in players.indices {
            players[index].isFaceUp = false
            players[index].isAlreadyChosen = false
        }
    }
    
    mutating func saveSetUp() {
        var mailText = "Opstelling: \n"
        for position in positions {
            mailText += "Positie: " + position.content + " met speler: " + String(position.player) + "\n"
        }
        print(mailText)
    }
    
    struct Player: Identifiable {
        var isFaceUp: Bool = false
        var isAlreadyChosen: Bool = false
        var position: Array<Int>
        var content: String
        var id: Int
    }
    
    struct Position: Identifiable {
        var id: Int
        var content: String
        var isFilledIn: Bool = false
        var player: Int = 0
    }
}

