//
//  Diet.swift
//  Savoury
//
//  Created by An Luu on 26/9/24.
//

import Foundation

///  Defines enums for dietary preferences and allergies used in the Savoury app.
///  - Diet: Covers diets such as Vegan, Keto, and others, providing clear labels for UI display.
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
