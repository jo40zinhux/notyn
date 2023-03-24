//
//  OrderProtocol.swift
//  notyng
//
//  Created by João Pedro on 24/03/23.
//

import Foundation

public protocol OrderProtocol {
    func fetchOrderData()
    func fetchOrderFailData()
    func fetchTotalValueData(totalValue: String)
    func fetchTotalValueFailData()
}
