//
//  SortOption.swift
//  InvariantTask
//
//  Created by Martin Novak on 23.01.2024..
//

import Foundation

enum SortOptionShoppingList {
    case name, id
    
    var sortDescriptor: NSSortDescriptor {
        switch self {
        case .id:
            return NSSortDescriptor(key: "id", ascending: false)
        case .name:
            return NSSortDescriptor(key: "name", ascending: true)
        }
    }
    
}
