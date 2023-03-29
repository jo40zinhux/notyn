//
//  DashboardViewModel.swift
//  notyng
//
//  Created by João Pedro on 21/03/23.
//

import Foundation

public final class DashboardViewModel {
    
    public var delegate: DashboardProtocol?
    
    public var orders: [Order] = []
    private var fullOrdersList: [Order] = []
    
    public func fetchData() {
        DataManager.shared.getOrders(isOpen: true, completion: { allOrders in
            self.fullOrdersList = allOrders
            self.orders = self.fullOrdersList
            
            if self.orders.count > 0 {
                self.delegate?.fetchOrdersListData()
                self.getTotalValue()
            } else {
                self.delegate?.fetchOrdersListFailData()
                self.delegate?.fetchTotalValueFailData()
            }
        })
    }
    
    public func filterOrderByName(name: String) {
        orders = fullOrdersList
        orders = orders.filter({ $0.name.contains(name) })
        delegate?.fetchOrdersListData()
    }
    
    public func resetFilter() {
        orders = fullOrdersList
    }
    
    public func setOrderSelected(orderId: String) {
        DataManager.shared.selectedOrderId = orderId
    }
    
    public func getUniqueProducts(order: Order) -> [Product] {
        var uniqueProduct: [Product] = []
        if let products = order.products {
            for product in products {
                if !uniqueProduct.contains(where: {$0.productId == product.productId }) {
                    uniqueProduct.append(product)
                }
            }
            
            uniqueProduct = uniqueProduct.sorted(by: {$0.price < $1.price})
            
            return uniqueProduct
        } else {
            return []
        }
    }
    
    private func getTotalValue() {
        var totalValue: Int = 0
        if orders.count > 0 {
            for order in orders {
                if let products = order.products {
                    if products.count > 0 {
                        for product in products {
                            totalValue = totalValue + product.price
                        }
                    } else {
                        totalValue += 0
                    }
                }
                delegate?.fetchTotalValueData(totalValue: totalValue.toPriceString())
            }
        } else {
            delegate?.fetchTotalValueFailData()
        }
    }
}
