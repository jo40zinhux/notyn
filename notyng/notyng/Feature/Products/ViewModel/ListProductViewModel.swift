//
//  ListProductViewModel.swift
//  notyng
//
//  Created by João Pedro on 28/03/23.
//

import Foundation

public final class ListProductViewModel {
    
    public var delegate: ListProductProtocol?
    public var products: [Product] = []
    
    public func fetchData() {
        DataManager.shared.getAllProducts { allProducts in
            self.products = allProducts
            self.products = self.products.sorted(by: {$0.price < $1.price})
            self.delegate?.fetchData()
        }
    }
}
