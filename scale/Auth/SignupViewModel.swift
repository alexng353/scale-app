//
//  SignupViewModel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import Foundation

enum SignupError: Error {
    case invalidEmail
    case invalidPassword
    case signupFailed
    case noToken
    case badTokenData
    case unknown
}

@MainActor
class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var realName: String = ""

    @Published var isSigningUp: Bool = false

    public func signup() async throws {
        let client = getClient()
        isSigningUp = true

        guard validateEmail(email) else {
            isSigningUp = false
            throw SignupError.invalidEmail
        }

        // validateEmail guarantees an "@" to be within the email string
        let username = email.split(separator: "@").first.map(String.init)!

        guard let response = try? await client.signup(
            body: .json(.init(email: email, password: password,  real_name: realName, username:username))
        ).ok else {
            isSigningUp = false
            throw SignupError.signupFailed
        }

        guard let unbufferedText = try? response.body.plainText else {
            throw SignupError.noToken
        }

        guard let bufferedText = try? await String(collecting: unbufferedText, upTo: 8192) else {
            throw SignupError.badTokenData
        }

        print(bufferedText)
    }
}

