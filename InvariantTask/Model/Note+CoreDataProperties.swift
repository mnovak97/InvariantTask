//
//  Note+CoreDataProperties.swift
//  InvariantTask
//
//  Created by Martin Novak on 21.01.2024..
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var shoppingItems: NSSet?
    
    public var wrappedNote: String {
        note ?? "Unknown note"
    }
    
    public var wrappedTitle: String {
        title ?? "Unknown note title"
    }
    
    public var shoppingItemArray: [ShoppingListItem] {
        let set = shoppingItems as? Set<ShoppingListItem> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var shoppingItemsCount: Int {
        return shoppingItems?.count ?? 0
    }

}

// MARK: Generated accessors for shoppingItems
extension Note {

    @objc(addShoppingItemsObject:)
    @NSManaged public func addToShoppingItems(_ value: ShoppingListItem)

    @objc(removeShoppingItemsObject:)
    @NSManaged public func removeFromShoppingItems(_ value: ShoppingListItem)

    @objc(addShoppingItems:)
    @NSManaged public func addToShoppingItems(_ values: NSSet)

    @objc(removeShoppingItems:)
    @NSManaged public func removeFromShoppingItems(_ values: NSSet)

}

extension Note : Identifiable {

}
