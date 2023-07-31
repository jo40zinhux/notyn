//
//  PaymentOrderViewModel.swift
//  notyng
//
//  Created by João Pedro on 10/04/23.
//

import Foundation
import UIKit

public final class PaymentOrderViewModel {
    
    public var delegate: PaymentOrderProtocol?
    public var order: Order?
    public var methods: [Method] = [.pix, .card, .cash]
    public var selectedMethod = Method.pix
    public var selectedMethodDescription = ""
    
    public func setupProductsStackView() {
        let p = getUniqueProducts(products: order?.products ?? [])
        var productItemViews: [ProductItem] = []
        for product in p {
            let countSameProducts = countSameProduct(product: product)
            
            let productName = ProductItem(productName: product.name,
                                          productIcon: ProductType(rawValue: product.productType) ?? .water,
                                          productPrice: "\(countSameProducts)x \(product.price.toPriceString())")
            productName.translatesAutoresizingMaskIntoConstraints = false
            productItemViews.append(productName)
        }
        
        delegate?.fetchTotalValue(totalValue: setupTotalValue(products: order?.products ?? []))
        delegate?.fetchStackView(views: productItemViews)
    }
    
    public func saveOrder() {
        if var o = order {
            o.paymentType = selectedMethod.rawValue
            o.isOpen = false
            o.orderDateFinish = Date().formattedDate(format: "dd/MM/yyyy HH:mm")
            DataManager.shared.saveOrder(order: o) { result in
                if result {
                    self.delegate?.fetchSaveOrder()
                } else {
                    self.delegate?.fetchSaveFailOrder()
                }
            }
        }
    }
    
    public func getPaymentMethodDescriptionText(row: Int) -> String {
        let method = self.methods[row]
        return MethodIcon.getNameFromMethodType(method: method)
    }
    
    public func getPaymentMethodIcon(row: Int) -> UIImage? {
        let method = self.methods[row]
        return MethodIcon.getIconFromMethodType(method: method)
    }
    
    private func getUniqueProducts(products: [Product]) -> [Product] {
        var uniqueProduct: [Product] = []
        for product in products {
            if !uniqueProduct.contains(where: {$0.productId == product.productId }) {
                uniqueProduct.append(product)
            }
            uniqueProduct = uniqueProduct.sorted(by: {$0.price < $1.price})
        }
        return uniqueProduct
    }
    
    private func setupTotalValue(products: [Product]) -> String {
        var totalValue: Int = 0
        
        for product in products {
            totalValue = totalValue + product.price
        }
        
        return "Total: \(totalValue.toPriceString())"
    }
    
    private func countSameProduct(product: Product) -> Int {
        if let products = order?.products {
            return products.filter({$0.productId == product.productId}).count
        } else {
            return 0
        }
    }
}
