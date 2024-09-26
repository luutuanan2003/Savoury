//
//  DishImageView.swift
//  Savoury
//
//  Created by Elwiz Scott on 26/9/24.
//

import SwiftUI

struct ImageDishView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            if let imageUrl = URL(string: recipe.image) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()  // Show loading spinner while the image is being fetched
                }
            }
            Text(recipe.label)
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 8)
                .multilineTextAlignment(.center)
        }
        .frame(width: 160, height: 200)  // Adjust frame to fit in the grid
    }
}

