//
//  CardStyle.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .padding(30)
                .frame(height: 100)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray.opacity(0.30), radius: 20, x:0 ,y: 0)
        }
}

