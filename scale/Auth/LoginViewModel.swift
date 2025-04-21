//
//  LoginViewModel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import Foundation
import KeychainAccess

enum LoginError : Error {
    case LoginFailed
    case SavingTokenFailed
}

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    @Published var isLoggingIn: Bool = false

    public func login() async throws {
        let client = getClient()
        isLoggingIn = true;

        guard let response = try? await client.login(
            body: .json(.init(password: password, username: username))
        ).ok else {
            isLoggingIn = false
            throw LoginError.LoginFailed
        }

        print("login response:" , response)

    }
}
