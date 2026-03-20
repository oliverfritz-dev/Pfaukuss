//
//  HomeView.swift
//  Pfaukuss
//
//  Created by Privat on 20.03.26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Tap to activate")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Home")
        }
    }
}

