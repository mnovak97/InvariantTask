//
//  ShoppingListItemView.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

struct ShoppingListItemView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ShoppingListViewModel()
    @State var changesMade: Bool = false
    @State var initialSetName: Bool = false
    @State var initialSetAmount: Bool = false
    @State var showAlert = false
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
        .onChange(of: viewModel.name) {
            if initialSetName {
                initialSetName = false
            } else {
                changesMade = true
            }
        }
        .onChange(of: viewModel.amount) {
            if initialSetAmount {
                initialSetAmount = false
            } else {
                changesMade = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Discard Changes?"),
                message: Text("Are you sure you want to discard changes?"),
                primaryButton: .default(Text("Discard")) {
                    dismiss()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if changesMade {
                        showAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
            }
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
                        initialSetName = true
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
                        initialSetAmount = true
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
                            dismiss()
                    }
                }, label: {
                     Text("Edit")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                        
                })
                Spacer()
                Button(action: {
                    if let item = shoppingItem {
                        viewModel.delete(shoppingItem: item)
                        dismiss()
                    }
                }, label: {
                     Text("Delete")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.red)))
                        
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
                    dismiss()
                }, label: {
                     Text("Save")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                        
                })
                .disabled(viewModel.name.isEmpty || viewModel.amount == 0)
                .opacity((viewModel.name.isEmpty || viewModel.amount == 0) ? 0.5 : 1.0)
            }
        }
        .padding()
    }
}

#Preview {
    ShoppingListItemView(viewType: ViewType.create)
}
