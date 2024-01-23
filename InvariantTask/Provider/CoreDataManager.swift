//
//  DataController.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import CoreData
import Foundation

class CoreDataManager {
    let container : NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    func fetchObjects<T: NSManagedObject>(entityName: String, sortBy sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        
        let request: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = sortDescriptors
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func delete<T:NSManagedObject> (_ item: T) {
        viewContext.delete(item)
        save()
    }
    
    
    func saveShoppingListItem(name:String, amount: Double) {
        let shoppingListItem = ShoppingListItem(context: CoreDataManager.shared.viewContext)
        shoppingListItem.id = UUID()
        shoppingListItem.name = name
        shoppingListItem.amount = amount
        shoppingListItem.creationDate = Date()
        
        save()
    }
    
    func editShoppingListItem(_ item: ShoppingListItem, name: String, amount: Double) {
        item.name = name
        item.amount = amount
        save()
    }
    
    func editNote(_ item: Note, title: String, note: String, shoppingListItems: [ShoppingListItem]) {
        item.title = title
        item.note = note
        
        for shoppingListItem in shoppingListItems {
            item.addToShoppingItems(shoppingListItem)
        }
        
        save()
    }
    
    func saveNote(title: String, note: String, shoppingListItems: [ShoppingListItem]) {
        let noteItem = Note(context: CoreDataManager.shared.viewContext)
        noteItem.id = UUID()
        noteItem.title = title
        noteItem.note = note
        noteItem.creationDate = Date()
        
        for shoppingListItem in shoppingListItems {
            noteItem.addToShoppingItems(shoppingListItem)
        }
        
        save()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Error while saving: \(error.localizedDescription)")
        }
    }
    
    private func createAndSaveShoppingListItem(name: String, amount: Double) {
        let newItem = ShoppingListItem(context: viewContext)
        newItem.id = UUID()
        newItem.name = name
        newItem.amount = amount
        newItem.creationDate = Date()
    
        save()
    }
    
    private func createAndSaveNote(title: String, note: String, shoppingItems: [ShoppingListItem]) {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.note = note
        newNote.creationDate = Date()
        newNote.addToShoppingItems(NSSet(array: shoppingItems))
        
        save()
    }
    
    private init() {
        container = NSPersistentContainer(name: "InvariantTask")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { _, error in
            if let error {
                print("Data failed to load: \(error.localizedDescription)")
            }
        }
        
        if fetchObjects(entityName: "Note").isEmpty {
            createAndSaveNote(title: "Kupnja", note: "Kupi brzo", shoppingItems: [])
            createAndSaveNote(title: "Kupnja", note: "Nemoj zaboravit", shoppingItems: [])
        }
        
        if fetchObjects(entityName: "ShoppingListItem").isEmpty {
            createAndSaveShoppingListItem(name: "Mljeko", amount: 2.5)
            createAndSaveShoppingListItem(name: "Kruh", amount: 1.5)
        }
    }
}
