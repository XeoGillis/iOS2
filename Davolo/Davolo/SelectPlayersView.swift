//
//  SelectPlayersView.swift
//  Davolo
//
//  Created by Xeo Gillis on 06/11/2022.
//

import SwiftUI

// main view
struct SelectPlayersView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
            ZStack {
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.players) { player in
                                PlayerSelectView(index: player, viewModel: viewModel)
                            }
                        }
                    }.padding(.horizontal).foregroundColor(DavoloColor.Table)
                    ButtonSelectView(viewModel: viewModel)
                }
            }.background(DavoloColor.Background).navigationTitle("Selecteer spelers")
    }
}

// animation view, one per player
struct PlayerSelectView: View {
    let index: Game.Player
    @ObservedObject var viewModel: VolleyballGame
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay = 0.3
    
    // based on code found on the Internet, slightly tweaked
    func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0.0
            }
        }
    }
    // end of code found on the Internet
    
    var body: some View {
        ZStack {
            CardFront(player: index, viewModel: viewModel, degree: $frontDegree)
            CardBack(player: index, viewModel: viewModel, degree: $backDegree)
        }.onTapGesture {
            flipCard()
            viewModel.addPlayer(with: index.id)
        }
        
    }
}

// view to imitate the front of a card
struct CardFront: View {
    let player: Game.Player
    @ObservedObject var viewModel: VolleyballGame
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            let shape = Rectangle()
            shape.fill(DavoloColor.Table).frame(minHeight: 70).shadow(radius: 15)
            HStack {
                Spacer()
                Text(player.content).font(.body).foregroundColor(DavoloColor.Text)
                Spacer()
            }
            HStack {
                Text("✓").foregroundColor(.green).frame(minWidth: 50, alignment: .trailing)
                Spacer()
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

// view to imitate the back of a card
struct CardBack: View {
    let player: Game.Player
    @ObservedObject var viewModel: VolleyballGame
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            let shape = Rectangle()
            shape.fill(DavoloColor.Table).frame(minHeight: 70).shadow(radius: 15)
            HStack {
                Spacer()
                Text(player.content).font(.body).foregroundColor(DavoloColor.Text)
                Spacer()
            }
            HStack {
                Spacer()
                Text("❌").frame(minWidth: 50, alignment: .leading)
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

// view with code for the buttons
struct ButtonSelectView: View {
    @ObservedObject var viewModel: VolleyballGame
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        Spacer()
        HStack {
            NavigationLink(destination: PositionListView(viewModel: viewModel)) {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Text("👉").font(.largeTitle)
                }.padding(.horizontal)
            }
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}
