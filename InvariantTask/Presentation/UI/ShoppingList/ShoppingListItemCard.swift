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
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text("Količina: \(formattedAmount)")
                    .font(.subheadline)
                Spacer()
            }
        }
        .padding(30)
        .frame(height: 100)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: Color.gray.opacity(0.30), radius: 20, x:0 ,y: 0)
    }
}

#Preview {
    ShoppingListItemCard(name: "Mljeko", amount: 2.5006)
}
