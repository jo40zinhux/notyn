//
//  ProductType.swift
//  notyng
//
//  Created by João Pedro on 19/03/23.
//

import Foundation
import UIKit

enum ProductType : Int16 {
    case beer
    case snack
    case water
    case soda
    case juice
    case energyDrink
    case isotonic
    case lollipop
    
}

struct ProductIcon {
    static let beer = "ic_beer"
    static let snack = "ic_snack"
    static let water = "ic_water"
    static let soda = "ic_soda"
    static let juice = "ic_juice"
    static let energyDrink = "ic_energy_drink"
    static let isotonic = "ic_isotonic"
    static let lollipop = "ic_lollipop"
    
    public static func getIconNameForType(productType: ProductType) -> String? {
        switch productType {
            
        case .beer:
            return ProductIcon.beer
        case .snack:
            return ProductIcon.snack
        case .water:
            return ProductIcon.water
        case .soda:
            return ProductIcon.soda
        case .juice:
            return ProductIcon.juice
        case .energyDrink:
            return ProductIcon.energyDrink
        case .isotonic:
            return ProductIcon.isotonic
        case .lollipop:
            return ProductIcon.lollipop
        }
    }
}
