//
//  Order+CoreDataProperties.swift
//  notyng
//
//  Created by João Pedro on 21/03/23.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var isOpen: Bool
    @NSManaged public var name: String?
    @NSManaged public var orderDateCreate: Date?
    @NSManaged public var orderDateFinish: Date?
    @NSManaged public var orderId: Int16
    @NSManaged public var paymentType: Int16
    @NSManaged public var totalValue: Int16
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Order {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Order : Identifiable {

}
