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
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.players) { player in
                    if (player.isSelected) {
                        PlayerView(player: player, viewModel: viewModel)
                    }
                }
            }
        }.padding(.horizontal).foregroundColor(DavoloColor.Table)
    }
}

struct PlayerView: View {
    let player: Game.Player
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        if player.isFaceUp {
            Button(action: {
                viewModel.choosePlayer(player.id)
                navigator.pop {
                    navigator.wrappedValue.path = "/davolo"
                }
            }) {
                ZStack {
                    let shape = Rectangle()
                    shape.fill(DavoloColor.Table).frame(minHeight: 70).shadow(radius: 15)
                    Text(player.content).font(.body).foregroundColor(DavoloColor.Text)
                }
            }
        }
    }
}

struct ButtonsReturnView: View {
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        Spacer()
        HStack {
            Button(action: {
                navigator.pop {
                    navigator.wrappedValue.path = "/davolo"
                }
            }) {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Text("👈").font(.largeTitle)
                }.padding(.horizontal)
            }
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}
