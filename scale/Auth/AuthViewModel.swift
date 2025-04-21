//
//  AuthModel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import Foundation

enum AuthViews {
    case login
    case signup
}

class AuthViewModel: ObservableObject {
    @Published var currentView: AuthViews = .login;
}
