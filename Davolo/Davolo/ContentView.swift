//
//  ContentView.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import SwiftUI

let positions = [4, 3, 2, 5, 6, 1, 7]

struct ContentView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        VStack {
            Text("Opstelling").font(.largeTitle)
            HStack {
                ScrollView {
                    VStack {
                        Text("Spelers").font(.title).foregroundColor(.yellow)
                        ForEach(viewModel.players) {
                            player in PlayerView(player: player)
                        }
                    }
                }.padding(.horizontal).foregroundColor(.teal)
                RightView(model: viewModel)
            }
            ButtonView()
        }
    }
}

struct RightView: View {
    @ObservedObject var model : VolleyballGame
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack {
            Text("Posities").font(.title).foregroundColor(.yellow)
            LazyVGrid(columns: columns) {
                ForEach(positions, id: \.self) {
                    position in PositionView(position: position).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                        model.choosePosition(Int(position))
                    }
                }
            }
            Spacer()
        }.padding(.horizontal)
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
    let position: Int
    
    var body: some View {
        ZStack {
            let shape = Rectangle()
            shape.fill()
            Text(position.description).foregroundColor(.blue)
        }.foregroundColor(.teal)
    }
}

struct ButtonView: View {
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        HStack {
            ZStack {
                shape.fill()
                shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
                Button("❌"){}
            }
            Spacer()
            ZStack {
                shape.fill()
                shape.strokeBorder(lineWidth: 3).foregroundColor(.green)
                Button("✔️"){}
            }
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = VolleyballGame()
        ContentView(viewModel: game).preferredColorScheme(.dark)
        ContentView(viewModel: game).preferredColorScheme(.light)
    }
}
