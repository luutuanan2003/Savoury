//
//  Allergy.swift
//  Savoury
//
//  Created by An Luu on 26/9/24.
//

import Foundation


///  Defines enums for dietary preferences and allergies used in the Savoury app.
///  - Allergy: Includes categories like Dairy Free, Gluten Free, etc., each with a descriptive label.
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
    
    var apiValue: String {
        switch self {
        case .dairyFree:
            return "dairy-free"
        case .glutenFree:
            return "gluten-free"
        case .peanutFree:
            return "peanut-free"
        case .shellfishFree:
            return "shellfish-free"
        }
    }
}
