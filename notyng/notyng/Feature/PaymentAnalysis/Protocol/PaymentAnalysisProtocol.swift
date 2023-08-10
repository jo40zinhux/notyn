//
//  PaymentAnalysisProtocol.swift
//  notyng
//
//  Created by João Pedro on 06/08/23.
//

import Foundation

public protocol PaymentAnalysisProtocol {
    func fetchPaymentEntriesData()
    func fetchPaymentEntriesFailData()
    func fetchTotalValueByType(totalValue: String)
}
