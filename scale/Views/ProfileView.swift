//
//  ProfileView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import SwiftUI
import KeychainAccess

struct ProfileView: View {
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    var body: some View {
        Button(action: {
            let keychain = Keychain(service: "icu.ayo.scale")
            // TODO: banner or something
            try? keychain.remove("auth.token")
            isSignedIn = false
        }) {
            Text("Sign Out")
        }
    }
}

#Preview {
    ProfileView()
}
