//
//  ShoppingListViewModel.swift
//  InvariantTask
//
//  Created by Martin Novak on 16.01.2024..
//

import Foundation

class ShoppingListViewModel : ObservableObject {
    @Published var name : String = ""
    @Published var amount : Double = 0.0
    @Published var shoppingListItems : [ShoppingListItem] = []
    
    init() {
        fetchShoppingListItems()
    }
    
    func fetchShoppingListItems() {
        shoppingListItems = CoreDataManager.shared.fetchObjects(entityName: "ShoppingListItem")
    }
    
    func delete(shoppingItem: ShoppingListItem) {
        CoreDataManager.shared.delete(shoppingItem)
    }
    
    func edit(item: ShoppingListItem, name: String, amount: Double) {
        CoreDataManager.shared.editShoppingListItem(item, name: name, amount: amount)
    }
    
    func save() {
        let shoppingListItem = ShoppingListItem(context: CoreDataManager.shared.viewContext)
        shoppingListItem.id = UUID()
        shoppingListItem.name = name
        shoppingListItem.amount = amount
        shoppingListItem.creationDate = Date()
        
        CoreDataManager.shared.save()
    }
}
