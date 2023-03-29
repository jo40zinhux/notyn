//
//  ListProductProtocol.swift
//  notyng
//
//  Created by João Pedro on 24/03/23.
//

import Foundation


public protocol ProductProtocol {
    func selectedProduct(product: Product)
}


public protocol ListProductProtocol {
    func fetchData()
    func fetchFailData()
}
