//
//  Dish.swift
//  Savoury
//
//  Created by An Luu on 22/8/24.
//

// Checked by An 1/9/24

import Foundation

/// A struct representing a dish in the application.
/// This model holds all the relevant details about a dish, including its name, type, image, favorite status, and ingredients.
struct Dish: Hashable {
    var name: String
    var type: String
    var image: String
    var isFavorite: Bool
    var ingredients: [String]
    
    init(name: String, type: String, image: String, isFavorite: Bool, ingredients: [String]) {
        self.name = name
        self.type = type
        self.image = image
        self.isFavorite = isFavorite
        self.ingredients = ingredients
    }
    
    init() {
        self.init(name: "", type: "", image: "", isFavorite: false, ingredients: [""])
    }
}
