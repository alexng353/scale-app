//
//  LoginView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import SwiftUI
import KeychainAccess

struct LoginView: View {
    @AppStorage("isSignedIn") var isSignedIn: Bool = false;
    @State private var username: String = "";
    @State private var password: String = "";
    @FocusState private var emailFieldIsFocused
    @FocusState private var passwordFieldIsFocused
    var body: some View {
        VStack(spacing: 12){
            VStack(alignment: .leading, spacing: 4) {
                Text("Username or Email Address")
                TextField("Username (Email Address)", text: $username)
                    .focused($emailFieldIsFocused)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Password")
                SecureField("Password", text: $password)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
            }
            
            Button("Login") {
//                print("Password: " + password + " Username: " + username)
                
                
                let keychain = Keychain(service: "icu.ayo.scale")
                keychain["access_token"] = "";
            }
                .padding()
                .background(.green.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
