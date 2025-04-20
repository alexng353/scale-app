//
//  ContentView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            ProfileView().tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}
