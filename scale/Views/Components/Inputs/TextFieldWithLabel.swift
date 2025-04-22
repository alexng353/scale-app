//
//  TextInputWithLabel.swift
//  scale
//
//  Created by Alexander Ng on 2025-04-21.
//

import SwiftUI

struct TextFieldWithLabel: View {
    var labelText: String
    var placeHolderText: String
    @Binding var text: String

    init(labelText: String, text: Binding<String>) {
        self.labelText = labelText
        self._text = text
        self.placeHolderText = labelText
    }

    init(labelText: String, placeHolderText: String, text: Binding<String>) {
        self.labelText = labelText
        self.placeHolderText = placeHolderText
        self._text = text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(labelText)
            TextField(placeHolderText, text: $text)
                .textInputAutocapitalization(.never) // TODO: make this configurable
                .disableAutocorrection(true)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
    }
}
