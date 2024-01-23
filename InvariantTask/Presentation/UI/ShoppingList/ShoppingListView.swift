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
                Picker("Sort By", selection: $viewModel.sortBy) {
                    Text("ID").tag(SortOptionShoppingList.id)
                    Text("Name").tag(SortOptionShoppingList.name)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    ForEach(viewModel.shoppingListItems) { item in
                        
                        ZStack {
                            NavigationLink(destination: ShoppingListItemView(shoppingItem: item, viewType: ViewType.edit)) {
                                EmptyView()
                            }
                            .opacity(0)
                            ShoppingListItemCard(name: item.wrappedName, amount: item.amount)
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
                            .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
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
