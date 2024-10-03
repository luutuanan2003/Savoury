//
//  IngredientSelectionView.swift
//  Savoury
//
//  Created by Kien Le on 27/9/24.
//

import SwiftUI

/// View to display the list of ingredients and trigger the recipe search
struct IngredientSelectionView: View {
    /// Track selected ingredients
    @State private var selectedIngredients: [String] = []
    
    /// Example ingredients
    @State private var availableIngredients = ["Chicken", "Cucumber", "Onion", "Tomato", "Garlic", "Pasta"]
    
    /// Track new ingredient input
    @State private var newIngredient = ""
    
    /// Control visibility of new ingredient input
    @State private var isAddingNewIngredient = false
    
    /// Track if search results should be shown
    @State private var showResults = false

    /// Use the RecipeSearch ViewModel
    @ObservedObject var recipeViewModel = RecipeSearch()
    
    /// Layout configuration for displaying in a grid with flexible columns.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Title
                HStack {
                    Text("Select Ingredients")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)

                // Ingredient selection list
                List {
                    ForEach(availableIngredients, id: \.self) { ingredient in
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
                    
                    // "Add ingredients..." button
                    if !isAddingNewIngredient {
                        Button(action: {
                            isAddingNewIngredient = true  // Show input for new ingredient
                        }) {
                            HStack {
                                Text("Add ingredients...")
                                Spacer()
                                Image(systemName: "plus.circle")
                            }
                            .foregroundColor(.black)
                        }
                    } else {
                        // TextField to input new ingredient
                        HStack {
                            TextField("Enter new ingredient", text: $newIngredient)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                            
                            // Button to add new ingredient
                            Button(action: {
                                if !newIngredient.isEmpty {
                                    availableIngredients.append(newIngredient.capitalized)  // Add the new ingredient to the list
                                    newIngredient = ""  // Clear input field
                                }
                                isAddingNewIngredient = false  // Hide input field after adding
                            }) {
                                Text("Add")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .bold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Capsule().fill(Color.yellow))
                            }
                        }
                    }
                }
                .padding(.top, -10)
                
                // Button to trigger search
                Button(action: {
                    recipeViewModel.clearRecipes() // Clear old results
                    recipeViewModel.searchRecipes(forSelectedIngredients: selectedIngredients)
                    showResults = true  // Show results when search is triggered
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
                // Navigate to RecipeResultsView when `showResults` is true
                .navigationDestination(isPresented: $showResults) {
                    RecipeResultsView(recipes: recipeViewModel.recipes)
                }
            }
        }
    }
}

/// New view to display the search results
struct RecipeResultsView: View {
    let recipes: [RecipeHit]  // Pass the recipes to the new view

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Search Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if !recipes.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(recipes, id: \.id) { recipeHit in
                            ImageDishView(recipe: recipeHit.recipe)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("No recipes found. Try different ingredients.")
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
