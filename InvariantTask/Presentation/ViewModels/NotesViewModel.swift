//
//  NotesViewModel.swift
//  InvariantTask
//
//  Created by Martin Novak on 21.01.2024..
//

import Foundation

class NotesViewModel : ObservableObject {
    @Published var title: String = ""
    @Published var note: String = ""
    @Published var notes : [Note] = []
    @Published var shoppingListAdded: [ShoppingListItem] = []
    @Published var sortBy: SortOptionsNotes = .id {
        didSet {
            fetchNotes()
        }
    }
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        if sortBy == .linkedItems {
            notes = CoreDataManager.shared.fetchObjects(entityName: "Note")
                    .sorted { $0.shoppingItemsCount > $1.shoppingItemsCount }
        } else {
            notes = CoreDataManager.shared.fetchObjects(entityName: "Note", sortBy: [sortBy.sortDescriptor])
        }
    }
    
    func delete(note: Note) {
        CoreDataManager.shared.delete(note)
    }
    
    func edit(noteItem: Note, title: String, note: String, shoppingList: [ShoppingListItem]) {
        CoreDataManager.shared.editNote(noteItem, title: title, note: note, shoppingListItems: shoppingList)
    }
    
    func save() {
        CoreDataManager.shared.saveNote(title: title, note: note, shoppingListItems: shoppingListAdded)
    }
    
}
