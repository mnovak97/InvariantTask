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
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        notes = CoreDataManager.shared.fetchObjects(entityName: "Note")
    }
    
    func delete(note: Note) {
        CoreDataManager.shared.delete(note)
    }
    
}
