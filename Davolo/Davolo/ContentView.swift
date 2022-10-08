//
//  ContentView.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import SwiftUI

let players = ["Sophie", "Lieselotte", "Manon", "Lindsey", "Lieze", "Leontien", "Lien", "Remie", "Merel", "Laura", "Elke", "Luka", "Romanie"]

let positions = [2, 3, 4, 5, 6, 1]

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Opstelling").font(.largeTitle)
            HStack {
                LeftView()
                RightView()
            }
            ButtonView()
        }
    }
}

struct LeftView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Spelers").font(.title).foregroundColor(.yellow)
                ForEach(players, id: \.self) {
                    player in PlayerView(player: player)
                }
            }
        }.padding(.horizontal).foregroundColor(.teal)
    }
}

struct RightView: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack {
            Text("Opslag").font(.title).foregroundColor(.yellow)
            LazyVGrid(columns: columns) {
                ForEach(positions, id: \.self) {
                    position in PositionView(position: position).aspectRatio(2/3, contentMode: .fit)
                }
            }
            Text("Receptie").font(.title).foregroundColor(.yellow)
            LazyVGrid(columns: columns) {
                ForEach(positions, id: \.self) {
                    position in PositionView(position: position).aspectRatio(2/3, contentMode: .fit)
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct PlayerView: View {
    let player: String

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius:30)
            shape.fill()
            Text(player).font(.body).foregroundColor(.blue)
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
                Button("✅"){}
            }
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}
