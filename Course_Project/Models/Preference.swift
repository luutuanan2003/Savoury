//
//  Preference.swift
//  Savoury
//
//  Created by An Luu on 23/9/24.
//

import Foundation

enum Allergy: CaseIterable, CustomStringConvertible {
    case dairyFree, glutenFree, peanutFree, shellfishFree

    var description: String {
        switch self {
        case .dairyFree:
            return "Dairy Free"
        case .glutenFree:
            return "Gluten Free"
        case .peanutFree:
            return "Peanut Free"
        case .shellfishFree:
            return "Shellfish Free"
        }
    }
}

enum Diet: CaseIterable, CustomStringConvertible {
    case vegan, vegetarian, porkFree, keto, lowFat, highProtein, highFiber, balanced

    var description: String {
        switch self {
        case .vegan:
            return "Vegan"
        case .vegetarian:
            return "Vegetarian"
        case .porkFree:
            return "Pork Free"
        case .keto:
            return "Keto"
        case .lowFat:
            return "Low Fat"
        case .highProtein:
            return "High Protein"
        case .highFiber:
            return "High Fiber"
        case .balanced:
            return "Balanced"
        }
    }
}


