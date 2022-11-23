//
//  DavoloApp.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import SwiftUI

@main
struct DavoloApp: App {
    let game = VolleyballGame()
    var body: some Scene {
        WindowGroup {
            RouterView(viewModel: game).background(DavoloColor.Background)
        }
    }
}
