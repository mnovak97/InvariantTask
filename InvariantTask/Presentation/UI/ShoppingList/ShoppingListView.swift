//
//  ShoppingListView.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.shoppingListItems) { item in
                        
                        ZStack {
                            NavigationLink(destination: ShoppingListItemView(shoppingItem: item, viewType: ViewType.edit)) {
                                EmptyView()
                            }
                            .opacity(0)
                            ShoppingListItemCard(name: item.name ?? "", amount: item.amount)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                
                HStack {
                    NavigationLink {
                        ShoppingListItemView(viewType: ViewType.create)
                    } label: {
                        Text("Add shopping item")
                            .padding()
                            .bold()
                            .background(Color(.systemBlue))
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .onAppear {
                viewModel.fetchShoppingListItems()
            }
        }
    }
}

#Preview {
    ShoppingListView()
}