//
//  AppDelegate.swift
//  notyng
//
//  Created by João Pedro on 18/03/23.
//

import UIKit
import CoreData
import FirebaseCore
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        DataManager.shared.removeOldOrder()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DashboardViewController()
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        return true
    }
}
