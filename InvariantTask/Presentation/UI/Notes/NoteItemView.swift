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
    
    @State var showAlert = false
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
            Spacer()
            HStack {
                Button(action: {
                   
                }, label: {
                     Text("Edit")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                        
                })
                Spacer()
                Button(action: {
                    
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
            
            Spacer()
            HStack {
                Button(action: {
                    
                    dismiss()
                }, label: {
                     Text("Save")
                        .frame(width: 100,height: 50)
                        .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                        
                })
            }
        }
        .padding()
    }
}

#Preview {
    NoteItemView(viewType: ViewType.edit)
}
