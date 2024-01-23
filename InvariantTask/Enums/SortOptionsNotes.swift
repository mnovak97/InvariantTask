//
//  SortOptionsNotes.swift
//  InvariantTask
//
//  Created by Martin Novak on 23.01.2024..
//

import Foundation
enum SortOptionsNotes {
    case id, title, linkedItems
    
    var sortDescriptor: NSSortDescriptor {
        switch self {
        case .id:
            return NSSortDescriptor(key: "id", ascending: false)
        case .title:
            return NSSortDescriptor(key: "title", ascending: true)
        case .linkedItems:
            return NSSortDescriptor()
        }
    }
}
