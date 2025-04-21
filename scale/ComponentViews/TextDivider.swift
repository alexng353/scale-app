//
//  TextDivider.swift
//  edubeyond-ios-4
//
//  Created by Vincent Qi on 2024-07-29.
//

import SwiftUI

struct TextDivider<Content: View>: View {
    let content: Content


    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Divider()
                    .padding(.horizontal, 10)
            }
            content
            VStack {
                Divider()
                    .padding(.horizontal, 10)
            }
        }
    }
}
#Preview {
    TextDivider() {
        Text("Text")
    }
}
