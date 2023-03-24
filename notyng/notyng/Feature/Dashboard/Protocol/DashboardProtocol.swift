//
//  DashboardProtocol.swift
//  notyng
//
//  Created by João Pedro on 21/03/23.
//

import Foundation

public protocol DashboardProtocol {
    func fetchOrdersListData()
    func fetchOrdersListFailData()
    func fetchTotalValueData(totalValue: String)
    func fetchTotalValueFailData()
}
