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
    public func saveOrder(order: Order, completion: @escaping(Bool) -> Void) {
        let orderDoc = database.document(Firebase.orders)
        
        var data: [String : Any] = [String : Any]()
        var updatedOrders: [[String : Any]] = []
        
        getOrders(isOpen: true) { allOrders in
            for o in allOrders {
                if o.orderId != order.orderId {
                    updatedOrders.append(o.toDict())
                }
            }
            updatedOrders.append(order.toDict())
            data = ["data" : updatedOrders]
            
            orderDoc.setData(data, merge: true) { err in
                if err != nil {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
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



