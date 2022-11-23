//
//  LoginView.swift
//  Davolo
//
//  Created by Xeo Gillis on 07/11/2022.
//

import SwiftUI
import Router

struct LoginView: View {
    @State private var username: String = ""
    @State private var usernameFilledIn = true
    @State private var validUsername = true
    @ObservedObject var viewModel: VolleyballGame
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    let shape = RoundedRectangle(cornerRadius: 30)

    var body: some View {
        Spacer()
        Text("Welkom bij de DavoloApp! Het principe is dat u een geldig emailadres ingeeft en daarna kan u opstellingen maken van Davolo Promo Twee en de resultaten ontvangen via mail. Succes!").foregroundColor(DavoloColor.Text).padding(.horizontal).multilineTextAlignment(.center)
        Spacer()
        HStack {
            Text("Emailadres").foregroundColor(DavoloColor.Input)
            TextField(
                "Emailadres",
                text: $username
            ).foregroundColor(DavoloColor.Input).padding(.horizontal).background(DavoloColor.Table).shadow(radius: 10)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
        }.padding(.horizontal)
        if !usernameFilledIn { Text("Emailadres moet ingevuld zijn!").foregroundColor(.red) }
        else if !validUsername { Text("Emailadres moet een '@' bevatten!").foregroundColor(.red) }
        else { Text("Log snel in!").foregroundColor(DavoloColor.Background) }
        Spacer()
        HStack {
            ZStack {
                shape.fill()
                shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                Button("👉"){
                    if username == "" { usernameFilledIn = false; validUsername = true }
                    else if !username.contains("@") { usernameFilledIn = true; validUsername = false }
                    else {
                        viewModel.setMail(username)
                        navigator.push {
                            navigator.wrappedValue.path = "/"
                        }
                    }
                }.shadow(radius: 10)
            }.padding(.horizontal)
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}
