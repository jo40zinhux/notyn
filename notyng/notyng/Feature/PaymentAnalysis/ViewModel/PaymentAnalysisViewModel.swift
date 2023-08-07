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
    
    public func fetchData () {
        DataManager.shared.getOrders { allOrders in
            self.orders = allOrders
            
            if self.orders.count > 0 {
                self.orders = self.orders.sorted(by: {$0.orderDateFinish < $1.orderDateFinish})
                self.getPaymentEntries()
            } else {
                self.delegate?.fetchPaymentEntriesFailData()
            }
        }
    }
    
    private func getPaymentEntries() {
        let pix = orders.filter({ ($0.paymentType == Method.pix.rawValue) && ($0.orderDateFinish != "") }).count
        let card = orders.filter({ ($0.paymentType == Method.card.rawValue) && ($0.orderDateFinish != "") }).count
        let money = orders.filter({ ($0.paymentType == Method.cash.rawValue) && ($0.orderDateFinish != "") }).count
        
        paymentEntries.append(pix)
        paymentEntries.append(card)
        paymentEntries.append(money)
        
        self.delegate?.fetchPaymentEntriesData()
    }
}
