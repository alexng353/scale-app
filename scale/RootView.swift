//
//  RootView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import SwiftUI

struct RootView: View {
    @AppStorage("isSignedIn") var isSignedIn: Bool = false;
    var body: some View {
        if (isSignedIn) {
            ContentView()
        } else {
            AuthView()
        }
    }
}

#Preview {
    RootView()
}
