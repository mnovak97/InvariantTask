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
    @Published var sortBy: SortOptionShoppingList = .id {
        didSet {
            fetchShoppingListItems()
        }
    }
    
    init() {
        fetchShoppingListItems()
    }
    
    func fetchShoppingListItems() {
        shoppingListItems = CoreDataManager.shared.fetchObjects(entityName: "ShoppingListItem", sortBy: [sortBy.sortDescriptor])
    }
    
    func delete(shoppingItem: ShoppingListItem) {
        CoreDataManager.shared.delete(shoppingItem)
    }
    
    func edit(item: ShoppingListItem, name: String, amount: Double) {
        CoreDataManager.shared.editShoppingListItem(item, name: name, amount: amount)
    }
    
    func save() {
        CoreDataManager.shared.saveShoppingListItem(name: name, amount: amount)
    }
}
