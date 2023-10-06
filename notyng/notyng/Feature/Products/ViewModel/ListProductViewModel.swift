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
    private var allProduct: [Product] = []
    
    public func fetchData() {
        DataManager.shared.getAllProducts { allProducts in
            self.products = allProducts
            self.allProduct = allProducts
            self.products = self.products.sorted(by: {$0.price < $1.price})
            self.delegate?.fetchData()
        }
    }
    
    public func filterProductByName(name: String) {
        self.products = self.allProduct
        self.products = self.products.filter({
            $0.name.lowercased().contains(name.lowercased())
        })
        self.delegate?.fetchData()
    }
    
    public func clearFilter() {
        self.products = self.allProduct
        self.delegate?.fetchData()
    }
}
