//
//  RecipeDetailView.swift
//  Savoury
//
//  Created by Elwiz Scott on 27/9/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Recipe Image
                if let imageUrl = URL(string: recipe.image) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                // Recipe Title
                Text(recipe.label)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Source and URL
                if let source = recipe.source, let url = recipe.url {
                    Text("Source: \(source)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Link("View Full Recipe", destination: URL(string: url)!)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
                
                // Yield and Calories
                HStack {
                    if let yield = recipe.yield {
                        Text("Servings: \(Int(yield))")
                    }
                    if let calories = recipe.calories {
                        Text("Calories: \(Int(calories)) kcal")
                    }
                }
                .font(.subheadline)
                .padding(.horizontal)
                
                // Diet Labels
                if let dietLabels = recipe.dietLabels, !dietLabels.isEmpty {
                    Text("Diet Labels: \(dietLabels.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                
                // Health Labels
                if let healthLabels = recipe.healthLabels, !healthLabels.isEmpty {
                    Text("Health Labels: \(healthLabels.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                
                // Ingredients
                if let ingredients = recipe.ingredients {
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(ingredients, id: \.food) { ingredient in
                        Text("• \(ingredient.food)")
                            .padding(.horizontal)
                            .font(.body)
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Recipe Details", displayMode: .inline)
        }
    }
}

// Preview
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(label: "Sample Recipe", image: "https://example.com/image.jpg", source: "Example Source", url: "https://example.com", yield: 4, calories: 200, dietLabels: ["Low-Fat"], healthLabels: ["Vegan"], ingredients: [Ingredient(food: "Chicken"), Ingredient(food: "Salt")]))
    }
}


