//
//  Category.swift
//  Course_Project
//
//  Created by Elwiz Scott on 24/8/24.
//

import Foundation

enum Category {
    case popular, recently, dessert, maindishes
    
    var categoryName: String {
        switch self {
        case .popular:
            return "Popular"
        case .recently:
            return "Recently"
        case .dessert:
            return "Dessert"
        case .maindishes:
            return "Main Dishes"
        }
    }
    
    
    var categorySymbol: String {
        switch self {
        case .popular:
            return "flame.fill"
        case .recently:
            return "clock"
        case .dessert:
            return "popcorn.fill"
        case .maindishes:
            return "fork.knife"
        }
    }
    
    static var allItems: [Category] {
        return [.popular, .recently, .dessert, .maindishes]
    }
}
