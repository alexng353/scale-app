//
//  AuthView.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-20.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var authVM: AuthViewModel = AuthViewModel()

    var body: some View {
        switch(authVM.currentView) {
            case .login:
                LoginView(authVM: authVM)
            case .signup:
                Text("not done yet")
        }
    }
}

#Preview {
    AuthView()
}
