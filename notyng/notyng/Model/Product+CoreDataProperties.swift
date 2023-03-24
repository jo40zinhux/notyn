//
//  Product+CoreDataProperties.swift
//  notyng
//
//  Created by João Pedro on 20/03/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Int16
    @NSManaged public var productType: Int16
    @NSManaged public var productId: Int16
    @NSManaged public var productIcon: String?
    @NSManaged public var order: Order?

}

extension Product : Identifiable {

}
