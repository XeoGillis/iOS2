//
//  ContentView.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        VStack {
            Text("Opstelling").font(.largeTitle)
            HStack {
                ScrollView {
                    VStack {
                        Text("Spelers").font(.title).foregroundColor(.yellow)
                        ForEach(viewModel.players) { player in
                            PlayerView(player: player)
                                .onTapGesture {
                                    viewModel.choosePlayer(player.id)
                                }
                        }
                    }
                }.padding(.horizontal).foregroundColor(.teal)
                VStack {
                    Text("Posities").font(.title).foregroundColor(.yellow)
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.positions) { position in
                            PositionView(position: position)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choosePosition(position.id)
                                }
                        }
                    }
                    Spacer()
                }.padding(.horizontal)
            }
            Spacer()
            HStack {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
                    Button("❌"){
                        viewModel.cancelSetUp()
                    }
                }.padding(.horizontal)
                Spacer()
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.green)
                    Button("✔️"){
                        viewModel.saveSetUp()
                    }
                }.padding(.horizontal)
            }.foregroundColor(.white).frame(height: 40).padding(.vertical)
        }
    }
}

struct PlayerView: View {
    let player: Game.Player

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius:30)
            shape.fill()
            if player.isFaceUp {
                Text(player.content).font(.body).foregroundColor(.blue)
            }
        }
    }
}

struct PositionView: View {
    let position: Game.Position
    
    var body: some View {
        if (position.isFilledIn) {
            ZStack {
                let shape = Rectangle()
                shape.fill()
                Text(position.content).foregroundColor(.blue)
            }.foregroundColor(.green)
        }
        else {
            ZStack {
                let shape = Rectangle()
                shape.fill()
                Text(position.content).foregroundColor(.blue)
            }.foregroundColor(.teal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = VolleyballGame()
        ContentView(viewModel: game).preferredColorScheme(.dark)
        ContentView(viewModel: game).preferredColorScheme(.light)
    }
}
