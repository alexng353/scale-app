//
//  LoginView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import SwiftUI
import KeychainAccess

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel = AuthViewModel()
    @ObservedObject var loginVM: LoginViewModel = LoginViewModel()

    @AppStorage("isSignedIn") var isSignedIn: Bool = false;

    var body: some View {
        VStack(spacing: 12){
            TextFieldWithLabel(
                labelText: "Email",
                text: $loginVM.email,
            )
            SecureFieldWithLabel(
                labelText: "Password",
                text: $loginVM.password
            )

            VStack{
                Button(action: {
                    Task {
                        do {
                            try await loginVM.login()
                            isSignedIn = true
                        } catch {
                            print("Login Failed?")
                        }
                    }
                }) {
                    Text("Log In")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            }
            .alert("Login Error", isPresented: Binding<Bool>(
                get: { loginVM.error != nil },
                set: { if !$0 { loginVM.error = nil } }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(loginVM.error?.errorDescription ?? "Something went wrong.")
            }

            TextDivider {
                Text("or")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }

            Button(action: {
                authVM.currentView = .signup
            }) {
                Text("Sign Up")

            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
