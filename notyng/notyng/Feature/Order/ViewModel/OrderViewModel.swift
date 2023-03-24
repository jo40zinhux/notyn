//
//  OrderViewModel.swift
//  notyng
//
//  Created by João Pedro on 24/03/23.
//

import Foundation

public final class OrderViewModel {
    
    public var delegate: OrderProtocol?
    public var order: Order?
    private var products: [Product] = []
    public var distinctProducts: [Product] = []
    
    public func fetchData() {
        order = DataManager.shared.getSelectedOrder()
        
        if let o = order {
            if let p = o.products?.allObjects as? [Product] {
                products = p
                distinctProducts = removeDuplicatedProduct()
                distinctProducts = distinctProducts.sorted(by: {$0.price < $1.price})
                delegate?.fetchOrderData()
                delegate?.fetchTotalValueData(totalValue: setupTotalValue())
            } else {
                products = []
                delegate?.fetchOrderFailData()
            }
        } else {
            delegate?.fetchOrderFailData()
        }
    }
    
    public func getCountProducts(product: Product) -> Int {
        let filteredProducts = products.filter({$0.productId == product.productId})
        return filteredProducts.count
    }
    
    private func removeDuplicatedProduct() -> [Product] {
        var uniqueProduct: [Product] = []
        for product in products {
            if !uniqueProduct.contains(where: {$0.productId == product.productId }) {
                uniqueProduct.append(product)
            }
        }
        return uniqueProduct
    }
    
    private func setupTotalValue() -> String {
        var totalValue: Int16 = 0

        for product in products {
            totalValue = totalValue + product.price
        }

        return "\(totalValue.toPriceString())"
    }
}
