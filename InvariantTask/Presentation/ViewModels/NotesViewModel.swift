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
    
    @Published var option: SortOptionShoppingList = .id {
        didSet {
            sortShoppingList(by: option)
        }
    }
    
    init() {
        fetchNotes()
    }
    
    func sortShoppingList(by option: SortOptionShoppingList) {
        shoppingListAdded.sort { item1 , item2 in
            switch option {
            case .name:
                return item1.wrappedName < item2.wrappedName
            case .id:
                return item1.id > item2.id
            case .creationDate:
                return item1.creationDate! > item2.creationDate!
            }
        }
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
