//
//  VolleyballGame.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation
class VolleyballGame: ObservableObject {
    static let players = [Player(id: 1, name: "Sophie", position: ["Hitter"]), Player(id: 3, name: "Lieselotte", position: ["Setter"]), Player(id: 4, name: "Manon", position: ["Middle"]), Player(id: 5, name: "Lindsey", position: ["Hitter", "Middle"]), Player(id: 6, name: "Lieze", position: ["Middle"]), Player(id: 7, name: "Leontien", position: ["Hitter", "Middle", "Opposite"]), Player(id: 8, name: "Lien", position: ["Hitter", "Opposite"]), Player(id: 10, name: "Remie", position: ["Opposite", "Hitter"]), Player(id: 11, name: "Merel", position: ["Hitter", "Opposite"]), Player(id: 12, name: "Laura", position: ["Hitter", "Middle", "Opposite", "Libero"]), Player(id: 14, name: "Elke", position: ["Hitter", "Setter", "Opposite", "Libero"]), Player(id: 15, name: "Luka", position: ["Setter"]), Player(id: 17, name: "Romanie", position: ["Libero"])]

    
    struct Player: Identifiable {
        var id: Int
        var name: String
        var position: Array<String>
    }
}
