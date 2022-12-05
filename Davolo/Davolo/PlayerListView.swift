//
//  PlayerListView.swift
//  Davolo
//
//  Created by Xeo Gillis on 06/11/2022.
//

import SwiftUI
import Router

struct PlayerListView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
            ZStack {
                if viewModel.players.filter { $0.isSelected && $0.isFaceUp }.count > 0 {
                    VStack {
                        ForEach(viewModel.players) { player in
                            if (player.isSelected && player.isFaceUp) {
                                PlayerView(player: player, viewModel: viewModel)
                            }
                        }
                        Spacer()
                    }.padding(.horizontal).foregroundColor(DavoloColor.Table)
                }
                else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Er zijn geen spelers meer beschikbaar die op deze positie kunnen spelen").foregroundColor(DavoloColor.Text)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }.background(DavoloColor.Background).navigationTitle("Kies speler")
    }
}

struct PlayerView: View {
    let player: Game.Player
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
            Button(action: {
                viewModel.choosePlayer(player.id)
            }) {
                ZStack {
                    let shape = Rectangle()
                    shape.fill(DavoloColor.Table).frame(minHeight: 70, maxHeight: 70).shadow(radius: 15)
                    Text(player.content).font(.body).foregroundColor(DavoloColor.Text)
                }
            }
    }
}
