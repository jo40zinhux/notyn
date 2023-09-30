//
//  ProductType.swift
//  notyng
//
//  Created by João Pedro on 19/03/23.
//

import Foundation
import UIKit

enum ProductType : Int {
    case beer
    case snack
    case water
    case soda
    case juice
    case energyDrink
    case isotonic
    case lollipop
    case cleaning
    case football
    case sandwich
    case hotDog
    case coffee
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
    static let cleaning = "ic_cleaning"
    static let football = "ic_football"
    static let sandwich = "ic_sandwich"
    static let hotDog = "ic_hotdog"
    static let coffee = "ic_coffee"
    
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
        case .cleaning:
            return ProductIcon.cleaning
        case .football:
            return ProductIcon.football
        case .sandwich:
            return ProductIcon.sandwich
        case .hotDog:
            return ProductIcon.hotDog
        case .coffee:
            return ProductIcon.coffee
        }
    }
}
