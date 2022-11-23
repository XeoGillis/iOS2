//
//  SelectPlayersView.swift
//  Davolo
//
//  Created by Xeo Gillis on 06/11/2022.
//

import SwiftUI
import Router

struct SelectPlayersView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.players.indices) { player in
                    PlayerSelectView(index: player, viewModel: viewModel)
                }
            }
        }.padding(.horizontal).foregroundColor(DavoloColor.Table)
    }
}

struct PlayerSelectView: View {
    let index: Int
    @ObservedObject var viewModel: VolleyballGame
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay = 0.3
    
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
    
    var body: some View {
        ZStack {
            CardFront(index: index, viewModel: viewModel, degree: $frontDegree)
            CardBack(index: index, viewModel: viewModel, degree: $backDegree)
        }.onTapGesture {
            flipCard()
            viewModel.addPlayer(with: viewModel.players[index].id)
        }
        
    }
}

struct CardFront: View {
    let index: Int
    @ObservedObject var viewModel: VolleyballGame
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            let shape = Rectangle()
            shape.fill(DavoloColor.Table).frame(minHeight: 70).shadow(radius: 15)
            HStack {
                Spacer()
                Text(viewModel.players[index].content).font(.body).foregroundColor(DavoloColor.Text)
                Spacer()
            }
            HStack {
                Text("✓").foregroundColor(.green).frame(minWidth: 50, alignment: .trailing)
                Spacer()
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack: View {
    let index: Int
    @ObservedObject var viewModel: VolleyballGame
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            let shape = Rectangle()
            shape.fill(DavoloColor.Table).frame(minHeight: 70).shadow(radius: 15)
            HStack {
                Spacer()
                Text(viewModel.players[index].content).font(.body).foregroundColor(DavoloColor.Text)
                Spacer()
            }
            HStack {
                Spacer()
                Text("❌").frame(minWidth: 50, alignment: .leading)
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct ButtonSelectView: View {
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    @ObservedObject var viewModel: VolleyballGame
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        Spacer()
        HStack {
            Button(action: {
                navigator.pop {
                    navigator.wrappedValue.path = "/login"
                }
            }) {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Text("👈").font(.largeTitle)
                }.padding(.horizontal)
            }
            Button(action: {
                navigator.push {
                    navigator.wrappedValue.path = "/davolo"
                }
            }) {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Text("👉").font(.largeTitle)
                }.padding(.horizontal)
            }
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}
