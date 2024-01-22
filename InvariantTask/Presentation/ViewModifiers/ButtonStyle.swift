//
//  ButtonStyle.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .bold()
            .background(backgroundColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


