//
//  LoginViewModel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import Foundation
import KeychainAccess

enum LoginError: Error, LocalizedError {
    case LoginRequestFailed
    case BadPassword
    case UserNotFound
    case SavingTokenFailed
    case NoToken
    case BadTokenData
    case Unknown

    var errorDescription: String? {
        switch self {
            case .LoginRequestFailed: return "The login request failed. Please try again."
            case .BadPassword: return "Incorrect password. Please try again."
            case .UserNotFound: return "User not found. Check your username."
            case .SavingTokenFailed: return "Could not save the login token."
            case .NoToken: return "Login token is missing."
            case .BadTokenData: return "The token data is invalid."
            case .Unknown: return "An unknown error has occurred."
        }
    }
}

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: LoginError? = nil

    @Published var isLoggingIn: Bool = false

    public func login() async throws {
        do {
            try await self._login()
        } catch {
            switch (error) {
            case is LoginError:
                self.error = error as? LoginError
            default:
                throw error
            }
        }
    }

    private func _login() async throws {
        let client = getClient()
        isLoggingIn = true;

        guard let response = try? await client.login(
            body: .json(.init(email: email, password: password ))
        ) else {
            isLoggingIn = false
            throw LoginError.LoginRequestFailed
        }

        guard let ok = try? response.ok else {
            isLoggingIn = false
            if (try? response.notFound) != nil {
                throw LoginError.UserNotFound
            } else if (try? response.unauthorized) != nil {
                throw LoginError.BadPassword
            }

            print("Unknown error or unexpected response") // how did we get here
            throw LoginError.Unknown
        }

        guard let unbufferedText = try? ok.body.plainText else {
            isLoggingIn = false
            throw LoginError.NoToken
        }

        guard let token = try? await String(collecting: unbufferedText, upTo: 8192) else {
            isLoggingIn = false
            throw LoginError.BadTokenData
        }

        do {
            let keychain = Keychain(service: "icu.ayo.scale")
            try keychain.set(token, key: "auth.token")
        } catch {
            isLoggingIn = false
            throw LoginError.SavingTokenFailed
        }

        isLoggingIn = false
    }
}
