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
        order = Order(name: name.capitalized,
                      orderId: UUID().uuidString,
                      totalValue: 0,
                      orderDateCreate: Date().formattedDate(format: "dd/MM/yyyy HH:mm"),
                      orderDateFinish: "",
                      isOpen: true,
                      paymentType: 0)
        order?.products = []
        delegate?.fetchFooterView()
    }
    
    public func fetchData() {
        if let o = order {
            if let p = o.products, p.count > 0 {
                products = p
                distinctProducts = removeDuplicatedProduct()
                distinctProducts = distinctProducts.sorted(by: {$0.price < $1.price})
                delegate?.fetchOrderData()
                delegate?.fetchTotalValueData(totalValue: setupTotalValue())
                delegate?.fetchFooterView()
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
    
    public func hasProduct() -> Bool {
        let productCount = order?.products?.count ?? 0
        return productCount > 0
    }
    
    public func getCountProducts(product: Product) -> Int {
        let filteredProducts = products.filter({($0.productId == product.productId && ($0.productId != 49))})
        return filteredProducts.count
    }
    
    public func saveNewOrder(name: String) {
        if let order = order {
            DataManager.shared.saveOrder(order: order) { result in
                if result {
                    self.delegate?.fetchSaveOrderData()
                } else {
                    self.delegate?.fetchSaveOrderFailtData()
                }
            }
        }
    }
    
    public func validateFooterView() -> Bool {
        if let o = order {
            return o.isOpen
        } else {
            return true
        }
    }
    
    private func removeDuplicatedProduct() -> [Product] {
        var uniqueProduct: [Product] = []
        for product in products {
            if !uniqueProduct.contains(where: {
                ($0.productId == product.productId)
                && ($0.productId != 49) }) {
                uniqueProduct.append(product)
            }
        }
        return uniqueProduct
    }
    
    private func setupTotalValue() -> String {
        var totalValue: Double = 0
        
        for product in products {
            totalValue = totalValue + product.price
        }
        
        order?.totalValue = totalValue
        return "\(totalValue.toPriceString())"
    }
}
