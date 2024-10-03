//
//  userPreferences.swift
//  Savoury
//
//  Created by An Luu on 27/9/24.
//

import Foundation
import SwiftData

@Model
class addFavorite: Identifiable {
    var id: UUID
    var dish: String

    init(id: UUID = UUID(), dish: String) {
        self.id = id
        self.dish = dish
    }
}


