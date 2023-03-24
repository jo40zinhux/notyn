//
//  DataManager.swift
//  notyng
//
//  Created by João Pedro on 19/03/23.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    var selectedOrderId: String = ""
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "notyng")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Create Objects
    public func createOrder(name: String = "") -> Order {
        let order = Order(context: persistentContainer.viewContext)
        
        order.name = name
        order.orderId = UUID().uuidString
        order.totalValue = 0
        order.orderDateCreate = Date()
        order.orderDateFinish = Date()
        order.isOpen = true
        order.paymentType = 0
        order.products = []
        
        return order
    }
    
    public func createProduct(name: String, price: Int, productType: ProductType, productId: Int16 = 0) -> Product {
        let product = Product(context: persistentContainer.viewContext)
        
        product.name = name
        product.price = Int16(price)
        product.productType = productType.rawValue
        product.productId = productId
        product.productIcon = ProductIcon.getIconNameForType(productType: productType)
        
        return product
    }
    
    // MARK: - Fetch Objects
    public func getOrders(isOpen: Bool) -> [Order] {
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        var fetchedOrders: [Order] = []
        
        do {
            fetchedOrders = try persistentContainer.viewContext.fetch(request)
            fetchedOrders = fetchedOrders.filter({$0.isOpen == isOpen})
            fetchedOrders = fetchedOrders.sorted(by: {$0.orderDateCreate ?? Date() > $1.orderDateCreate ?? Date()})
        } catch let error {
            print("Error fetching orders \(error)")
        }
        
        return fetchedOrders
    }
    
    public func getSelectedOrder() -> Order? {
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        var fetchedOrders: [Order] = []
        
        do {
            fetchedOrders = try persistentContainer.viewContext.fetch(request)
            fetchedOrders = fetchedOrders.filter({$0.orderId == self.selectedOrderId})
            
        } catch let error {
            print("Error fetching orders \(error)")
        }
        
        return fetchedOrders.first
    }
    
    public func getProducts(order: Order) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "order = %@", order)
        var fetchedProducts: [Product] = []
        
        do {
            fetchedProducts = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        
        return fetchedProducts
    }
    
    //MARK: - Delete Objects
    public func deleteOrder(order: Order) {
        let context = persistentContainer.viewContext
        context.delete(order)
        saveContext()
    }
    
    public func deleteAllOrders() {
        let context = persistentContainer.viewContext
        let orders = getOrders(isOpen: true)
        
        for order in orders {
            context.delete(order)
        }
        
        saveContext()
    }
    
    public func deleteProduct(product: Product) {
        let context = persistentContainer.viewContext
        context.delete(product)
        saveContext()
    }
    
    public func deleteProduct(products: [Product]) {
        let context = persistentContainer.viewContext
        
        for product in products {
            context.delete(product)
        }
        
        saveContext()
    }
}



