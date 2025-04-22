//
//  SignupViewModel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import Foundation
import KeychainAccess

enum SignupError: Error, LocalizedError {
    case InvalidEmail
    case InvalidPassword
    case SignupFailed
    case NoToken
    case BadTokenData
    case unknown

    var errorDescription: String? {
        switch self {
            case .InvalidEmail:
                return "The email address is invalid."
            case .InvalidPassword:
                return "Your password must meet the required criteria."
            case .SignupFailed:
                return "Signup failed. Please try again later."
            case .NoToken:
                return "No token was received after signup."
            case .BadTokenData:
                return "The token data is corrupted or invalid."
            case .unknown:
                return "An unknown error occurred during signup."
        }
    }
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
            throw SignupError.InvalidEmail
        }

        guard let response = try? await client.signup(
            body: .json(.init(email: email, password: password,  real_name: realName))
        ).ok else {
            isSigningUp = false
            throw SignupError.SignupFailed
        }

        guard let unbufferedText = try? response.body.plainText else {
            throw SignupError.NoToken
        }

        guard let token = try? await String(collecting: unbufferedText, upTo: 8192) else {
            throw SignupError.BadTokenData
        }

        let keychain = Keychain(service: "icu.ayo.scale")
        try keychain.set(token, key: "auth.token")
    }
}

