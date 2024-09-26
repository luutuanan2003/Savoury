//
//  Category.swift
//  Savoury
//
//  Created by Kien Le on 24/8/24.
//

// Checked by An Luu 1/9/24

import Foundation


/// Enum representing different categories used within the application.
/// Each case corresponds to a specific type of category, such as popular items, recently added items, desserts, and main dishes.
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
    
    /// SF-Symbol to return the system symbol name associated with each case.
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
