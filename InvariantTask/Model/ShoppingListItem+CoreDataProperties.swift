//
//  ShoppingListItem+CoreDataProperties.swift
//  InvariantTask
//
//  Created by Martin Novak on 21.01.2024..
//
//

import Foundation
import CoreData


extension ShoppingListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingListItem> {
        return NSFetchRequest<ShoppingListItem>(entityName: "ShoppingListItem")
    }

    @NSManaged public var amount: Double
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var shoppingNote: Note?
    
    public var wrappedName: String {
        name ?? "Unknown shopping item"
    }

}

extension ShoppingListItem : Identifiable {

}
