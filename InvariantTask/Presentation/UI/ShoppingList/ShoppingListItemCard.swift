//
//  ShoppingListItemCard.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

struct ShoppingListItemCard: View {
    let name: String
    let amount: Double
    
    private var formattedAmount: String {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = amount.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 3
            return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(name)
                    .modifier(MainTextStyle())
                Spacer()
            }
            HStack {
                Text("Quantity: \(formattedAmount)")
                    .modifier(TextStyle())
                Spacer()
            }
        }
        .modifier(CardStyle())
    }
}

#Preview {
    ShoppingListItemCard(name: "Mljeko", amount: 2.5006)
}
