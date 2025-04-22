//
//  HomeViewModel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var weight: Double = 0.0

    func save() async throws {
        let client = getClient()

        guard let response = try? await client.log_weight(
            body: .json(.init(unit: .LBs, weight: self.weight))
        ) else {
            print("oopsie daisy we had a fucky wucky")
            return
        }

        guard let ok = try? response.ok else {
            print("couldn't get ok")
            return
        }
    }
}
