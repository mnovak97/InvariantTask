//
//  TextStyle.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(Color.gray)
    }
}

