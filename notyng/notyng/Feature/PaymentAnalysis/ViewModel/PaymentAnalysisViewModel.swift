//
//  PaymentAnalysisViewModel.swift
//  notyng
//
//  Created by João Pedro on 06/08/23.
//

import Foundation

public final class PaymentAnalysisViewModel {
    public var delegate: PaymentAnalysisProtocol?
    
    public var paymentEntries: [Int] = []
    private var orders: [Order] = []
    private var fullOrders: [Order] = []
    
    public func fetchData () {
        DataManager.shared.getOrders { allOrders in
            self.fullOrders = allOrders
            
            if self.fullOrders.count > 0 {
                self.fullOrders = self.fullOrders.sorted(by: {$0.orderDateFinish < $1.orderDateFinish})
                self.getPaymentEntries()
            } else {
                self.delegate?.fetchPaymentEntriesFailData()
            }
        }
    }
    
    public func getOrderByPayment(method: Method) {
        self.orders = self.fullOrders
        self.orders =  self.orders.filter({ ($0.paymentType == method.rawValue) && (!$0.isOpen) })
        self.getTotalValue()
    }
    
    public func getOrdersFilteredByPayment() -> [Order] {
        return self.orders
    }
    
    private func getPaymentEntries() {
        let pix = fullOrders.filter({ ($0.paymentType == Method.pix.rawValue) && (!$0.isOpen) }).count
        let card = fullOrders.filter({ ($0.paymentType == Method.card.rawValue) && (!$0.isOpen) }).count
        let money = fullOrders.filter({ ($0.paymentType == Method.cash.rawValue) && (!$0.isOpen) }).count
        
        paymentEntries.append(pix)
        paymentEntries.append(card)
        paymentEntries.append(money)
        
        self.delegate?.fetchPaymentEntriesData()
    }
    
    private func getTotalValue() {
        var waitingValue: Double = 0
        var receivedValue: Double = 0
        if orders.count > 0 {
            for order in orders {
                waitingValue = waitingValue + order.totalValue
                if !order.isOpen {
                    receivedValue = receivedValue + order.totalValue
                }
            }
            
            let totalValue = "\(waitingValue.toPriceString())"
            delegate?.fetchTotalValueByType(totalValue: totalValue)
        }
    }
}
