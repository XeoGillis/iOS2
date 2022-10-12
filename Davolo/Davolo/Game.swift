//
//  Game.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation

struct Game {
    private(set) var positions: Array<Position> = [Position(id: 1), Position(id: 2), Position(id: 3), Position(id: 4), Position(id: 5), Position(id: 6)]
    private(set) var players: Array<Player>
    
    init(arrayOfPresentPlayers: Array<Int>) {
        players = Array<Player>()
        for number in arrayOfPresentPlayers {
            switch (number) {
            case 1: players.append(Player(position: ["Hitter"], content: "Sophie", id: number))
            case 2: players.append(Player(position: ["Hitter", "Opposite", "Middle"], content: "Romanie", id: number))
            case 3: players.append(Player(position: ["Setter"], content: "Lieselotte", id: number))
            case 4: players.append(Player(position: ["Middle"], content: "Manon", id: number))
            case 5: players.append(Player(position: ["Hitter", "Middle"], content: "Lindsey", id: number))
            case 6: players.append(Player(position: ["Middle"], content: "Lieze", id: number))
            case 7: players.append(Player(position: ["Hitter", "Middle", "Opposite"], content: "Leontien", id: number))
            case 8: players.append(Player(position: ["Hitter", "Opposite"], content: "Lien", id: number))
            case 10: players.append(Player(position: ["Hitter", "Opposite"], content: "Remie", id: number))
            case 11: players.append(Player(position: ["Hitter", "Opposite"], content: "Merel", id: number))
            case 12: players.append(Player(position: ["Hitter", "Middle", "Opposite"], content: "Laura", id: number))
            case 14: players.append(Player(position: ["Hitter", "Setter", "Opposite"], content: "Elke", id: number))
            case 15: players.append(Player(position: ["Setter"], content: "Luka", id: number))
            case 17: players.append(Player(position: ["Libero"], content: "Romanie", id: number))
            default: players.append(Player(position: ["Libero"], content: "Anoniem", id: number))
            }
        }
    }
    
    struct Position: Identifiable {
        var isFilledIn: Bool = false
        var id: Int
    }
    
    struct Player: Identifiable {
        var isFaceUp: Bool = false
        var isAlreadyChosen: Bool = false
        var position: Array<String>
        var content: String
        var id: Int
    }
}

