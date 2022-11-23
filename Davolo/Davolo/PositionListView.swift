//
//  PositionListView.swift
//  Davolo
//
//  Created by Xeo Gillis on 06/11/2022.
//

import SwiftUI
import Router

struct PositionListView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.positions) { position in
                    PositionView(position: position, viewModel: viewModel)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct PositionView: View {
    let position: Game.Position
    @ObservedObject var viewModel: VolleyballGame
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    
    var body: some View {
        Button(action: {
            viewModel.choosePosition(Int(position.content)!)
            navigator.push {
                navigator.wrappedValue.path = "/davolo/\(position)"
            }
        }) {
            if (position.isFilledIn) {
                ZStack {
                    let shape = Rectangle()
                    shape.fill().shadow(radius: 15)
                    Text(position.image).foregroundColor(DavoloColor.Title).font(.largeTitle)
                }.foregroundColor(DavoloColor.Table)
            }
            else {
                ZStack {
                    let shape = Rectangle()
                    shape.fill().shadow(radius: 15)
                    Text(position.content).foregroundColor(DavoloColor.Text)
                }.foregroundColor(DavoloColor.Table)
            }
        }
    }
}

struct ButtonsView: View {
    @ObservedObject var viewModel: VolleyballGame
    @State private var allPositions = false
    @State private var showPopUp = false
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        if (!showPopUp) {
            HStack {
                Button(action: {
                    viewModel.cancelSetUp()
                    navigator.pop {
                        navigator.wrappedValue.path = "/"
                    }
                }) {
                    ZStack {
                        shape.fill()
                        shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                        Text("👈").font(.largeTitle)
                    }.padding(.horizontal)
                }
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
                        viewModel.positions.forEach {
                            if !$0.isFilledIn { allPositions = false; return }
                            else { allPositions = true }
                        }
                        if allPositions { viewModel.saveSetUp() }
                        else { showPopUp = true }
                    }
                }.padding(.horizontal)
            }.foregroundColor(.white).frame(height: 40).padding(.vertical)
        }
        else {
            HStack {
                VStack {
                    Text("Oepsssss").foregroundColor(DavoloColor.Title)
                    Text("Niet alle posities werden ingevuld ...").foregroundColor(DavoloColor.Text).frame(width: 285)
                }
                Spacer()
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Button("👍"){
                        showPopUp = false
                    }
                }.padding(.horizontal)
            }.foregroundColor(.white).frame(height: 40).padding(.vertical)
        }
    }
}
