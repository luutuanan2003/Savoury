//
//  userPreferences.swift
//  Savoury
//
//  Created by An Luu on 27/9/24.
//

import Foundation
import SwiftData


/// Model class using Swift Data and using ORM managing favorite recipes
@Model
class AddFavorite: Identifiable {
    var id: UUID
    var dish: String

    init(id: UUID = UUID(), Recipe: String) {
        self.id = id
        self.dish = Recipe
    }
}


