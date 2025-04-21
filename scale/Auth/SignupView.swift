//
//  SignupView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var authVM: AuthViewModel = AuthViewModel()
    @ObservedObject var signupVM: SignupViewModel = SignupViewModel()

    @AppStorage("isSignedIn") var isSignedIn: Bool = false;

    var body: some View {
        VStack(spacing: 12){
            TextFieldWithLabel(
                labelText: "Full Name",
                text: $signupVM.realName
            )
            TextFieldWithLabel(
                labelText: "Email Address",
                text: $signupVM.email,
            )
            SecureFieldWithLabel(
                labelText: "Password",
                text: $signupVM.password
            )

            Button(action: {
                Task {
                    try await signupVM.signup()
                }
            }) {
                Text("Sign Up")
                    .foregroundStyle(.white)
            }
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke())

            TextDivider {
                Text("or")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }

            Button(action: {
                authVM.currentView = .signup
            }) {
                Text("Log In")
            }
        }
        .padding()
    }
}

#Preview {
    SignupView()
}
