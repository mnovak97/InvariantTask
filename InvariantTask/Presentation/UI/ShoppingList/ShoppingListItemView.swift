//
//  ShoppingListItemView.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

struct ShoppingListItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ShoppingListViewModel()
    @State private var changesMade: Bool = false
    var shoppingItem: ShoppingListItem?
    let viewType: ViewType
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        VStack {
            switch viewType {
            case .edit:
                editViewType(shoppingItem: shoppingItem)
            case .create:
                addViewType()
            }
        }
        .alert(isPresented: $changesMade) {
                    Alert(
                        title: Text("Discard Changes?"),
                        message: Text("You have unsaved changes. Are you sure you want to discard them?"),
                        primaryButton: .default(Text("Discard")) {
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
        }
        .onChange(of: viewModel.name) {
            changesMade = true
        }
        .onChange(of: viewModel.amount) {
            changesMade = true
        }
    }
}

extension ShoppingListItemView {
    func editViewType(shoppingItem: ShoppingListItem?) -> some View {
        VStack {
            Spacer()
            HStack {
                Text("Item name:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter item name", text:$viewModel.name )
                .textFieldStyle(.roundedBorder)
                .onAppear{
                    if let itemName = shoppingItem?.name {
                        viewModel.name = itemName
                    }
                }
            
            HStack {
                Text("Amount:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter item amount:" ,value: $viewModel.amount,  formatter: formatter)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onAppear {
                    if let itemAmount = shoppingItem?.amount {
                        viewModel.amount = itemAmount
                    }
                }
            HStack {
                Text("\(shoppingItem?.creationDate ?? Date())")
                    .foregroundStyle(Color.gray)
                Spacer()
            }
            Spacer()
            HStack {
                Button(action: {
                    if let item = shoppingItem {
                        viewModel.edit(item: item, name: viewModel.name, amount: viewModel.amount)
                        changesMade = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                     Text("Edit")
                        .frame(width: 100,height: 50)
                        .bold()
                        .background(Color(.systemBlue))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                })
                Spacer()
                Button(action: {
                    if let item = shoppingItem {
                        viewModel.delete(shoppingItem: item)
                        changesMade = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                     Text("Delete")
                        .frame(width: 100,height: 50)
                        .bold()
                        .background(Color(.red))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                })
            }
            .padding(.leading,20)
            .padding(.trailing,20)
        }
        .padding()
    }
    
    func addViewType() -> some View {
        VStack {
            Spacer()
            HStack {
                Text("Item name:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter item name", text:$viewModel.name )
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Text("Amount:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter item amount:" ,value: $viewModel.amount,  formatter: formatter)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            HStack {
                Button(action: {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                     Text("Save")
                        .frame(width: 100,height: 50)
                        .bold()
                        .background(Color(.systemBlue))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                })
            }
        }
        .padding()
    }
}

#Preview {
    ShoppingListItemView(viewType: ViewType.create)
}
