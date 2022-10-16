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
        for id in arrayOfPossiblePositions.sorted() {
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
            case 14: players.append(Player(position: [2, 5, 1, 4], content: "Elke", id: number))
            case 15: players.append(Player(position: [1], content: "Luka", id: number))
            case 17: players.append(Player(position: [7], content: "Romanie", id: number))
            default: print("Error in given player: " + String(number))
            }
        }
    }
    
    mutating func choosePosition(_ namedPosition : Int) {
        print("-----------------------------------------")
        print("Position: ")
        print("-----------------------------------------")
        print(namedPosition)
        print("-----------------------------------------")
        print("All players:")
        print("-----------------------------------------")
        for var player in players {
            player.isFaceUp = false
            print(player.content, player.isFaceUp)
        }
        let suitablePlayers = players.filter { $0.position.contains(namedPosition) }
        print("-----------------------------------------")
        print("Suitable players:")
        print("-----------------------------------------")
        for var player in suitablePlayers {
            player.isFaceUp = true
            print(player.content, player.isFaceUp)
        }
    }
    
    mutating func cancelSetUp() {
        for var position in positions {
            position.isFilledIn = false
        }
        for var player in players {
            player.isFaceUp = false
            player.isAlreadyChosen = false
        }
    }
    
    // Code based on code found on https://nemecek.be/blog/61/ios-14-how-to-send-email-using-default-email-app
    mutating func saveSetUp() {
        var mailText = "Opstelling:"
        for position in positions {
            mailText += "Positie: " + position.content + " met speler: " + String(position.player)
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

