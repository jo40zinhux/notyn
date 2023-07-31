//
//  Order.swift
//  notyng
//
//  Created by João Pedro on 19/03/23.
//
//

import FirebaseFirestore

public struct Order: Codable {
    let name: String
    let orderId: String
    var totalValue: Int
    let orderDateCreate: String
    var orderDateFinish: String
    var isOpen: Bool
    var paymentType: Int
    var products: [Product]?
    
    public func toDict() -> [String: Any] {
        var dataProducts: [[String : Any]] = [[String : Any]]()
        guard let products = products else { return [:] }
        for product in products {
            dataProducts.append(product.toDict())
        }
        
        return ["name" : name,
                "orderId" : orderId,
                "totalValue" : totalValue,
                "orderDateCreate" : orderDateCreate,
                "orderDateFinish" : orderDateFinish,
                "isOpen" : isOpen,
                "paymentType" : paymentType,
                "products" : dataProducts]
    }
}
