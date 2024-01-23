//
//  ItemPickerViewModel.swift
//  InvariantTask
//
//  Created by Martin Novak on 22.01.2024..
//

import Foundation
class ItemPickerViewModel : ObservableObject {
    @Published private (set) var items = [ShoppingListItem]()
    @Published var searchText:String = ""
    
    var searchableItems: [ShoppingListItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.wrappedName.contains(searchText) }
        }
    }
    
    init() {
        fetchShoppingItems()
    }
    
    func fetchShoppingItems() {
        items = CoreDataManager.shared.fetchObjects(entityName: "ShoppingListItem")
    }
    
    
}
