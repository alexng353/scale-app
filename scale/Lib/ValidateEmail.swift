//
//  File.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import Foundation

func validateEmail(_ email: String) -> Bool {
    let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

    let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    let range = NSRange(location: 0, length: email.utf16.count)

    return regex?.firstMatch(in: email, options: [], range: range) != nil
}
