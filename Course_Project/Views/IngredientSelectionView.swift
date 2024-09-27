//
//  IngredientSelectionView.swift
//  Savoury
//
//  Created by Elwiz Scott on 27/9/24.
//

import SwiftUI

struct IngredientSelectionView: View {
    @State private var selectedIngredients: [String] = []  // Track selected ingredients
    @ObservedObject var recipeViewModel = RecipeSearch()   // Use your RecipeSearch ViewModel
    let availableIngredients = ["Chicken", "Cheese", "Onion", "Tomato", "Garlic", "Pasta"] // Example ingredients
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            // Ingredient selection list
            List(availableIngredients, id: \.self) { ingredient in
                HStack {
                    Text(ingredient)
                    Spacer()
                    // Toggle selection
                    Image(systemName: selectedIngredients.contains(ingredient) ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            if selectedIngredients.contains(ingredient) {
                                selectedIngredients.removeAll { $0 == ingredient }
                            } else {
                                selectedIngredients.append(ingredient)
                            }
                        }
                }
            }
            
            // Button to trigger search
            Button(action: {
                recipeViewModel.searchRecipes(forSelectedIngredients: selectedIngredients)
            }) {
                Text("Search Recipes")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Capsule()
                        .fill(Color.yellow)
                        .frame(height: 50)
                        .shadow(radius: 4))
            }
            .padding()
            
            // Display recipes in grid
            if !recipeViewModel.recipes.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(recipeViewModel.recipes, id: \.id) { recipeHit in
                            ImageDishView(recipe: recipeHit.recipe)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("No recipes found. Start searching!")
                    .padding()
            }
        }
    }
}

// Preview
struct IngredientSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSelectionView()
    }
}
