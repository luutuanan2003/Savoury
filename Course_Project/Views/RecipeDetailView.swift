//
//  RecipeDetailView.swift
//  Savoury
//
//  Created by Kien Le on 27/9/24.
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
                            .aspectRatio(contentMode: .fill)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                // Recipe Title and Rating (Example Rating Placeholder)
                HStack {
                    Text(recipe.label)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)

                // Capsules for Total Time, Servings, Calories, Total Weight
                HStack {
                    if let totalTime = recipe.totalTime {
                        RecipeDetailCapsule(iconName: "clock", label: "\(Int(totalTime)) mins")
                    }
                    
                    if let yield = recipe.yield {
                        RecipeDetailCapsule(iconName: "person.2.fill", label: "\(Int(yield)) Servings")
                    }
                    
                    if let calories = recipe.calories {
                        RecipeDetailCapsule(iconName: "flame.fill", label: "\(Int(calories)) Cal")
                    }
                    
                    if let totalWeight = recipe.totalWeight {
                        RecipeDetailCapsule(iconName: "square.stack.3d.up.fill", label: "\(Int(totalWeight)) g")
                    }
                }
                .padding(.horizontal)
                
                // Ingredients
                if let ingredients = recipe.ingredients {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(ingredients, id: \.food) { ingredient in
                        Text("• \(ingredient.food)")
                            .padding(.horizontal)
                            .font(.body)
                    }
                }
                
                Spacer()

                // Optional additional sections (Cautions, Cuisine Type, etc.)
                if let cautions = recipe.cautions, !cautions.isEmpty {
                    Text("Cautions: \(cautions.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                
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
            }
            .navigationBarTitle("Recipe Details", displayMode: .inline)
        }
    }
}

// View to show each capsule for the recipe details
struct RecipeDetailCapsule: View {
    var iconName: String
    var label: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.yellow)
            Text(label)
                .font(.footnote)
                .bold()
        }
        .padding(12)
        .background(Capsule().fill(Color.yellow.opacity(0.2)))
    }
}

// Preview
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(
            recipe: Recipe(
                label: "Spaghetti Carbonara",
                image: "https://www.allrecipes.com/thmb/ewSWaXqsw97lWyAWek_u9fguJ3g=/0x512/filters:no_upscale():max_bytes(150000):strip_icc()/Easyspaghettiwithtomatosauce_11715_DDMFS_4x3_2424-8d7bf30b2622465f9dd78a2c6277eeb8.jpg",
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
