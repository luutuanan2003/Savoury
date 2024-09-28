//
//  userPreferences.swift
//  Savoury
//
//  Created by An Luu on 27/9/24.
//

import Foundation
import SwiftData

@Model
class userPreferences: Identifiable {
    var id: UUID
    var diets: [String]
    var allergies: [String]

    init(id: UUID = UUID(), allergies: [String], diets: [String]) {
        self.id = id
        self.allergies = allergies
        self.diets = diets
    }
}
