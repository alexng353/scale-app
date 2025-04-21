//
//  API.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import Foundation
import OpenAPIURLSession
import KeychainAccess

func getClient() -> Client {
    let keychain = Keychain(service: "icu.ayo.scale")
    
    let serverUrlString = "http://localhost:8080"; // diabolical - fix on prod please
//    guard let serverUrl = URL(string: serverUrlString) else {
//        throw APIInstantiationError.InvalidURL
//    }
    let serverUrl = URL(string: serverUrlString)!

    let transport = URLSessionTransport();
    guard let token = try? keychain.get("auth.token") else {
        return Client(serverURL: serverUrl, transport: transport)
    }

    print("token: " + token)
    
    let client = Client(
        serverURL: serverUrl,
        transport: transport,
        middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: token)]
    )
    return client;
}
