//
//  NoteItemView.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import SwiftUI

struct NoteItemView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = NotesViewModel()
    @State var changesMade: Bool = false
    @State var showAlert: Bool = false
    @State var initialSet: Bool = false
    @State var initialListSet: Bool = false
    @State private var selectedShoppingItem: ShoppingListItem?
    
    var noteItem: Note?
    let viewType: ViewType
    var body: some View {
        VStack {
            switch viewType {
            case .edit:
                editViewType(noteItem: noteItem)
            case .create:
                addViewType()
            }
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
        .onChange(of: [viewModel.note, viewModel.title]) {
            if initialSet {
                initialSet = false
            } else {
                changesMade = true
            }
        }
        .onChange(of: viewModel.shoppingListAdded) {
            if initialListSet {
                initialListSet = false
            } else {
                changesMade = true
            }
        }
        .alert("Discard Changes ?", isPresented: $showAlert) {
            Button("Discard") {
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message : {
            Text("Are you sure you want to discard changes?")
        }
    }
}

extension NoteItemView {
    func editViewType(noteItem: Note?) -> some View {
        VStack {
            Spacer()
            HStack {
                Text("Title:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter note title",text: $viewModel.title)
                .textFieldStyle(.roundedBorder)
                .onAppear {
                    if let noteTitle = noteItem?.wrappedTitle {
                        viewModel.title = noteTitle
                        initialSet = true
                    }
                }
            HStack {
                Text("Note:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter note text", text:$viewModel.note, axis: .vertical)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.roundedBorder)
                .onAppear {
                    if let noteText = noteItem?.wrappedNote {
                        viewModel.note = noteText
                    }
                }
            VStack {
                Picker("Sort By", selection: $viewModel.option) {
                    Text("ID").tag(SortOptionShoppingList.id)
                    Text("Name").tag(SortOptionShoppingList.name)
                    Text("Creation date").tag(SortOptionShoppingList.creationDate)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    ForEach(viewModel.shoppingListAdded) { item in
                        ShoppingListItemCard(name: item.wrappedName, amount: item.amount)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                
                NavigationLink(destination: ItemPickerView(selectedItem: $selectedShoppingItem, onItemSelected: {
                        if let selectedItem = selectedShoppingItem {
                            viewModel.shoppingListAdded.append(selectedItem)
                            selectedShoppingItem = nil
                            changesMade = true
                        }
                }), label: {
                    Text("Link shopping item")
                        .padding()
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                })
            }
            
            Spacer()
            HStack {
                Button(action: {
                    if let note = noteItem {
                        viewModel.edit(noteItem: note, title: viewModel.title, note: viewModel.note, shoppingList: viewModel.shoppingListAdded)
                    }
                    dismiss()
                }, label: {
                     Text("Edit")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                        
                })
                Spacer()
                Button(action: {
                    if let note = noteItem {
                        viewModel.delete(note: note)
                    }
                    dismiss()
                }, label: {
                     Text("Delete")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.red)))
                        
                })
            }
            .padding(.leading,20)
            .padding(.trailing,20)
        }
        .onAppear {
            if let noteShoppingList = noteItem?.shoppingItemArray {
                if viewModel.shoppingListAdded.isEmpty {
                    for shoppingItem in noteShoppingList {
                        viewModel.shoppingListAdded.append(shoppingItem)
                    }
                    initialListSet = true
                }
            }
        }
        .padding()
    }
    
    func addViewType() -> some View {
        VStack {
            Spacer()
            HStack {
                Text("Title:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter note title", text: $viewModel.title)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("Note:")
                    .font(.title2)
                Spacer()
            }
            TextField("Enter note text", text: $viewModel.note, axis: .vertical)
                .multilineTextAlignment(.leading)
                .textFieldStyle(.roundedBorder)
            VStack {
                Picker("Sort By", selection: $viewModel.option) {
                    Text("ID").tag(SortOptionShoppingList.id)
                    Text("Name").tag(SortOptionShoppingList.name)
                    Text("Creation date").tag(SortOptionShoppingList.creationDate)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    ForEach(viewModel.shoppingListAdded) { item in
                        ShoppingListItemCard(name: item.wrappedName, amount: item.amount)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                
                NavigationLink(destination: ItemPickerView(selectedItem: $selectedShoppingItem, onItemSelected: {
                        if let selectedItem = selectedShoppingItem {
                            viewModel.shoppingListAdded.append(selectedItem)
                            selectedShoppingItem = nil
                        }
                }), label: {
                    Text("Link shopping item")
                        .padding()
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                })
            }
            
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
                .disabled(viewModel.title.isEmpty)
                .opacity((viewModel.title.isEmpty) ? 0.5 : 1.0)
            }
        }
        .padding()
    }
}

#Preview {
    NoteItemView(viewType: ViewType.create)
}
