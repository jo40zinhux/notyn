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
    
    public func createOrder(name: String) {
        order = Order(name: name,
                      orderId: UUID().uuidString,
                      totalValue: 0,
                      orderDateCreate: Date().formattedDate(format: "dd/MM/yyyy HH:mm"),
                      orderDateFinish: "",
                      isOpen: true,
                      paymentType: 0)
        order?.products = []
    }
    
    public func fetchData() {
        if let o = order {
            if let p = o.products, p.count > 0 {
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
    
    public func addProductToOrder(product: Product) {
        if var products = order?.products {
            products.append(product)
            order?.products = products
            fetchData()
        }
    }
    
    public func removeProductToOrder(product: Product) {
        if var products = order?.products {
            if let index = products.firstIndex(of: product) {
                products.remove(at: index)
                order?.products = products
                fetchData()
            }
        }
    }
    
    public func getCountProducts(product: Product) -> Int {
        let filteredProducts = products.filter({$0.productId == product.productId})
        return filteredProducts.count
    }
    
    public func saveNewOrder(name: String) {
        if let products = order?.products {
            DataManager.shared.saveOrder(name: name,
                                         products: products,
                                         totalValue: self.getTotalValue()) { result in
                if result {
                    self.delegate?.fetchSaveOrderData()
                } else {
                    self.delegate?.fetchSaveOrderFailtData()
                }
            }
        }
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
        var totalValue: Int = 0
        
        for product in products {
            totalValue = totalValue + product.price
        }
        
        return "\(totalValue.toPriceString())"
    }
    
    private func getTotalValue() -> Int {
        var totalValue: Int = 0
        
        for product in products {
            totalValue = totalValue + product.price
        }
        
        return totalValue
    }
}
