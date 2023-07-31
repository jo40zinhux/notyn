//
//  PaymentOrderProtocol.swift
//  notyng
//
//  Created by João Pedro on 10/04/23.
//

import Foundation

public protocol PaymentOrderProtocol {
    func fetchTotalValue(totalValue: String)
    func fetchStackView(views: [ProductItem])
    func fetchSaveOrder()
    func fetchSaveFailOrder()
}
