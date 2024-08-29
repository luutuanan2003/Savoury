//
//  Dish.swift
//  a1-s3926655
//
//  Created by An Luu on 22/8/24.
//

import Foundation


struct Dish {
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
