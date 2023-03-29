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
    let totalValue: Int
    let orderDateCreate: String
    let orderDateFinish: String
    let isOpen: Bool
    let paymentType: Int
    var products: [Product]?
}
