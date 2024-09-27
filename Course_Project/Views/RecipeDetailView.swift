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
                
                // Total Weight and Total Time
                HStack {
                    if let totalWeight = recipe.totalWeight {
                        Text("Total Weight: \(Int(totalWeight)) g")
                    }
                    if let totalTime = recipe.totalTime {
                        Text("Total Time: \(Int(totalTime)) minutes")
                    }
                }
                .font(.subheadline)
                .padding(.horizontal)

                // Cautions
                if let cautions = recipe.cautions, !cautions.isEmpty {
                    Text("Cautions: \(cautions.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.horizontal)
                }

                // Cuisine Type, Meal Type, and Dish Type
                if let cuisineType = recipe.cuisineType, !cuisineType.isEmpty {
                    Text("Cuisine Type: \(cuisineType.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                if let mealType = recipe.mealType, !mealType.isEmpty {
                    Text("Meal Type: \(mealType.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                if let dishType = recipe.dishType, !dishType.isEmpty {
                    Text("Dish Type: \(dishType.joined(separator: ", "))")
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
        RecipeDetailView(
            recipe: Recipe(
                label: "Spaghetti Carbonara",
                image: "https://www.example.com/spaghetti.jpg",
                yield: 4,
                calories: 500,
                totalWeight: 800,
                totalTime: 25,
                cautions: ["Gluten", "Dairy"],
                ingredients: [
                    Ingredient(food: "Spaghetti"),
                    Ingredient(food: "Bacon"),
                    Ingredient(food: "Egg"),
                    Ingredient(food: "Parmesan cheese"),
                    Ingredient(food: "Black pepper")
                ],
                cuisineType: ["Italian"],
                mealType: ["Lunch", "Dinner"],
                dishType: ["Main course"]
            )
        )
    }
}
