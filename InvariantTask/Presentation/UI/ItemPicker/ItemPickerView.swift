//
//  ItemPickerView.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct ItemPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ItemPickerViewModel()
    @Binding var selectedItem: ShoppingListItem?
    var onItemSelected: (() -> Void)?
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding(.leading)
                .padding(.trailing)
            List {
                ForEach(viewModel.searchableItems) { item in
                    ShoppingListItemCard(name: item.wrappedName, amount: item.amount)
                        .onTapGesture {
                            if selectedItem == item {
                                selectedItem = nil
                            } else {
                                selectedItem = item
                            }
                        }
                        .foregroundStyle(selectedItem == item ? Color(.systemBlue) : Color.black)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
            
            Button {
                onItemSelected?()
                dismiss()
            } label: {
                Text("Add")
                    .padding()
                    .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
            }

        }
    }
}
