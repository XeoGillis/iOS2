//
//  PositionListView.swift
//  Davolo
//
//  Created by Xeo Gillis on 06/11/2022.
//

import SwiftUI

struct PositionListView: View {
    @ObservedObject var viewModel: VolleyballGame
    @Environment(\.verticalSizeClass) var vSize
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
            ZStack {
                VStack {
                    if (vSize == .regular) {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.positions) { position in
                                PositionView(position: position, viewModel: viewModel)
                                    .aspectRatio(2/3, contentMode: .fit)
                            }
                        }
                        Spacer()
                        ButtonsView(viewModel: viewModel)
                    }
                    else {
                        HStack {
                            LazyVGrid(columns: columns) {
                                ForEach(viewModel.positions) { position in
                                    if (position.content != "7") {
                                        PositionView(position: position, viewModel: viewModel)
                                            .aspectRatio(2/3, contentMode: .fit).frame(
                                                maxWidth: UIScreen.main.bounds.size.width/4,
                                                maxHeight: UIScreen.main.bounds.size.height/2 - 50)
                                    }
                                }
                            }
                            VStack {
                                ForEach(viewModel.positions) { position in
                                    if (position.content == "7") {
                                        PositionView(position: position, viewModel: viewModel)
                                            .aspectRatio(2/3, contentMode: .fit).frame(
                                                maxWidth: UIScreen.main.bounds.size.width/4,
                                                maxHeight: UIScreen.main.bounds.size.height/2 - 50)
                                    }
                                }
                                Spacer()
                                ButtonsView(viewModel: viewModel)
                            }
                        }
                    }
                }.padding(.horizontal)
            }.background(DavoloColor.Background).navigationTitle("Posities")
    }
}

struct PositionView: View {
    let position: Game.Position
    @StateObject var viewModel: VolleyballGame
    
    var body: some View {
                if (position.isFilledIn) {
                    NavigationLink (destination: PlayerListView(viewModel: viewModel)) {
                        ZStack {
                            let shape = Rectangle()
                            shape.fill().shadow(radius: 15)
                            AsyncImage(url: URL(string: position.image)) { image in
                                image.resizable()
                            } placeholder: {
                                DavoloColor.Table
                            }
                        }.foregroundColor(DavoloColor.Table)
                    }.simultaneousGesture(TapGesture().onEnded {
                        viewModel.choosePosition(Int(position.content)!)
                    })
                }
                else {
                    NavigationLink (destination: PlayerListView(viewModel: viewModel)) {
                        ZStack {
                            let shape = Rectangle()
                            shape.fill().shadow(radius: 15)
                            Text(position.content).foregroundColor(DavoloColor.Text)
                        }.foregroundColor(DavoloColor.Background)
                    }.simultaneousGesture(TapGesture().onEnded {
                        viewModel.choosePosition(Int(position.content)!)
                    })
                }
    }
}

struct ButtonsView: View {
    @ObservedObject var viewModel: VolleyballGame
    @State private var allPositions = false
    @State private var showPopUp = false
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        if (!showPopUp) {
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
