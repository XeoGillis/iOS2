//
//  ContentView.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import SwiftUI
import Router

struct RouterView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        Router("/login") {
            Route("/login") {
                VStack {
                    Text("Inloggen").font(.largeTitle)
                        .foregroundColor(DavoloColor.Title)
                    LoginView(viewModel: viewModel)
                }.background(DavoloColor.Background)
            }
            Route("/") {
                VStack {
                    Text("Selecteer spelers").font(.largeTitle).foregroundColor(DavoloColor.Title)
                    SelectPlayersView(viewModel: viewModel)
                    Spacer()
                    ButtonSelectView(viewModel: viewModel)
                }.background(DavoloColor.Background)
            }
            Route("/davolo") {
                VStack {
                    Text("Opstelling").font(.largeTitle).foregroundColor(DavoloColor.Title)
                    PositionListView(viewModel: viewModel)
                    Spacer()
                    ButtonsView(viewModel: viewModel)
                }.background(DavoloColor.Background)
            }
            Route("/davolo/{position}") {
                VStack {
                    Text("Selecteer speler").font(.largeTitle).foregroundColor(DavoloColor.Title)
                    PlayerListView(viewModel: viewModel)
                    ButtonsReturnView()
                }.background(DavoloColor.Background)
            }
        }.background(DavoloColor.Background)
    }
}

struct DavoloColor {
    static let Title = Color("TitleColor")
    static let Text = Color("TextColor")
    static let Table = Color("TableColor")
    static let Background = Color("BackgroundColor")
    static let Input = Color("InputColor")
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        let game = VolleyballGame()
        RouterView(viewModel: game).preferredColorScheme(.dark)
        RouterView(viewModel: game).preferredColorScheme(.light)
    }
}
