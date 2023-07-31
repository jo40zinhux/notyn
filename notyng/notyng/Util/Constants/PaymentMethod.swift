//
//  PaymentMethod.swift
//  notyng
//
//  Created by João Pedro on 10/04/23.
//

import Foundation
import UIKit

public enum Method : Int {
    case pix
    case cash
    case card
}

public struct MethodIcon {
    
    public static func getIconFromMethodType(method: Method) -> UIImage? {
        switch method {
        case .pix:
            return Icons.pix
        case .cash:
            return Icons.cash
        case .card:
            return Icons.card
        }
    }
    
    public static func getNameFromMethodType(method: Method) -> String {
        switch method {
        case .pix:
            return "Pix"
        case .cash:
            return "Dinheiro"
        case .card:
            return "Cartão"
        }
    }
}
