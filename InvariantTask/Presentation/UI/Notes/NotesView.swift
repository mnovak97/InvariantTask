//
//  NotesView.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import SwiftUI

struct NotesView: View {
    @StateObject private var viewModel = NotesViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Sort By", selection: $viewModel.sortBy) {
                    Text("ID").tag(SortOptionsNotes.id)
                    Text("Title").tag(SortOptionsNotes.title)
                    Text("Linked items").tag(SortOptionsNotes.linkedItems)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    ForEach(viewModel.notes) {
                        item in
                        
                        ZStack {
                            NavigationLink(destination: NoteItemView(noteItem: item, viewType: ViewType.edit)) {
                                EmptyView()
                            }
                            .opacity(0)
                            NotesCard(title: item.wrappedTitle, note: item.wrappedNote, linkedItems: item.shoppingItemArray.count)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                
                HStack {
                    NavigationLink {
                        NoteItemView(viewType: ViewType.create)
                    } label: {
                        Text("Add note")
                            .padding()
                            .modifier(ButtonStyle(backgroundColor: Color(.systemBlue)))
                    }
                }
            }
            .onAppear {
                viewModel.fetchNotes()
            }
        }
    }
}

#Preview {
    NotesView()
}
