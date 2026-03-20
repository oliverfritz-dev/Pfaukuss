//
//  PfaukussApp.swift
//  Pfaukuss
//
//  Created by Privat on 19.03.26.
//

import SwiftUI

@main
struct PfaukussApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isLoading {
                ProgressView()
            } else if appState.isLoggedIn {
                MainTabView()
                    .environmentObject(appState)
            } else {
                NavigationStack {
                    LoginView()
                        .environmentObject(appState)
                }
            }
        }
    }
}


