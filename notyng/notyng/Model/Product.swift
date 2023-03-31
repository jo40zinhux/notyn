//
//  Product.swift
//  notyng
//
//  Created by João Pedro on 20/03/23.
//
//

public struct Product: Codable, Equatable {
    let name: String
    let price: Int
    let productType: Int
    let productId: Int
    
    public func toDict() -> [String: Any] {
        return ["name" : name,
                "price" : price,
                "productId" : productId,
                "productType" : productType]
    }
    
    public static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.productId == rhs.productId
    }
}
