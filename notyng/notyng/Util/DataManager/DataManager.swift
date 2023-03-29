//
//  DataManager.swift
//  notyng
//
//  Created by João Pedro on 19/03/23.
//

import Foundation
import CoreData
import FirebaseFirestore

class DataManager {
    static let shared = DataManager()
    var selectedOrderId: String = ""
    private let database = Firestore.firestore()
    
    // MARK: - Create Objects
    public func saveOrder(name: String, products: [Product], totalValue: Int, completion: @escaping(Bool) -> Void) {
        
        //TODO: Receber o Order completo, não parcionado
        let createDate = Date().formattedDate(format: "dd/MM/yyyy HH:mm")
        let finishDate = Date().formattedDate(format: "dd/MM/yyyy HH:mm")
        let order = Order(name: name,
                          orderId: UUID().uuidString,
                          totalValue: totalValue,
                          orderDateCreate: createDate,
                          orderDateFinish: finishDate,
                          isOpen: true,
                          paymentType: 0,
                          products: products)
        
        let orderDoc = database.document(Firebase.orders)
        let arrayOrder: [Order] = [order]
        let data: [String: Any] = ["data": arrayOrder]
        
        orderDoc.setData(data)
    }
    
    // MARK: - Fetch Objects
    public func getOrders(isOpen: Bool, completion: @escaping([Order]) -> Void) {
        let orderDoc = database.document(Firebase.orders)
        orderDoc.getDocument { snapshotData, error in
            guard let snapData = snapshotData?.data(), error == nil else { return }
            
            do {
                if let sd = snapData["data"] {
                    let data = try JSONSerialization.data(withJSONObject: sd)
                    let decoder = JSONDecoder()
                    var orders = try decoder.decode([Order].self, from: data)
                    orders = orders.sorted(by: {$0.orderDateCreate.toDate() < $1.orderDateCreate.toDate()})
                    completion(orders)
                } else {
                    completion([])
                }
            } catch {
                completion([])
            }
        }
    }
    
    public func getAllProducts(completion: @escaping([Product]) -> Void) {
        let orderDoc = database.document(Firebase.products)
        orderDoc.getDocument { snapshotData, error in
            guard let snapData = snapshotData?.data(), error == nil else { return }
            
            do {
                if let sd = snapData["data"] {
                    let data = try JSONSerialization.data(withJSONObject: sd)
                    let decoder = JSONDecoder()
                    var products = try decoder.decode([Product].self, from: data)
                    products = products.sorted(by: {$0.productId < $1.productId})
                    completion(products)
                } else {
                    completion([])
                }
            } catch {
                completion([])
            }
        }
    }
}



