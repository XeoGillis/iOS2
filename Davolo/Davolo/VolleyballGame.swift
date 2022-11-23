//
//  VolleyballGame.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation

class VolleyballGame: ObservableObject {
    
    // ATTRIBUTES
    
    @Published var allPlayers: Array<Player> {
        didSet {
            updatePlayers(allPlayers)
        }
    }
    @Published var allPositions: Array<Position> {
        didSet {
            updatePositions(allPositions)
        }
    }
    var position = 0
    var mail = ""
    
    // INITIALIZATION AND SEEDING
    
    init() {
        allPlayers = Array<Player>()
        allPositions = Array<Position>()
        fillPlayers()
        fillPositions()
    }
    func fillPlayers() {
        Task {
            await callAPIplayers()
        }
    }
    func fillPositions() {
        Task {
            await callAPIpositions()
        }
    }
    func callAPIplayers() async {
        guard let url = URL(string: "http://localhost:9000/api/players") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode([Player].self, from: data)
                    DispatchQueue.main.async {
                        tasks.forEach { self.allPlayers.append($0) }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    func callAPIpositions() async {
        guard let url = URL(string: "http://localhost:9000/api/positions") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode([Position].self, from: data)
                    DispatchQueue.main.async {
                        tasks.forEach { self.allPositions.append($0) }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    // INITIALIZATION OF THE GAME

    static func createGame() -> Game {
        return Game()
    }
    @Published private var model: Game = createGame()
    var players: Array<Game.Player> {
        model.players
    }
    var positions: Array<Game.Position> {
        model.positions
    }
    
    // ALL FUNCTIONS DELEGATED TO MODEL
    
    func setMail(_ mail: String) {
        self.mail = mail
    }
    func selectAllPlayers() {
        model.selectAllPlayers()
    }
    func updatePlayers(_ allPlayers: Array<Player>) {
        model.updatePlayers(allPlayers)
    }
    func updatePositions(_ allPositions: Array<Position>) {
        model.updatePositions(allPositions)
    }
    func addPlayer(with number : Int) {
        model.addPlayer(with: number)
    }
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
        model.saveSetUp(mailto: mail)
    }
    
    // STRUCTS
    
    struct Player: Codable {
        let name: String
        let number: Int
        let position: String
    }
    struct Position: Codable {
        let id: Int
        let position: Int
    }
}
