//
//  SearchView.swift
//  Savoury
//
//  Created by Kien Le on 26/9/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var showIngredientsScreen: Bool
    @Binding var showRecipeScreen: Bool
    @Binding var showInstructionScreen: Bool
    
    // New state for search query
    @State private var searchQuery: String = ""
    
    // ViewModel to fetch recipes based on search query
    @ObservedObject var recipeViewModel = RecipeSearch()
    
    // Filtered recipes based on the search query
    var filteredRecipes: [RecipeHit] {
        if searchQuery.isEmpty {
            return recipeViewModel.recipes
        } else {
            return recipeViewModel.recipes.filter { $0.recipe.label.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
    
    // For grid layout similar to home screen
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    // ScrollView with LazyVGrid for a grid layout
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredRecipes, id: \.id) { recipeHit in
                                ImageDishView(recipe: recipeHit.recipe)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .searchable(text: $searchQuery, prompt: "Search recipes") // Add searchable to the ScrollView
                    .navigationTitle("Search Recipes") // Navigation title for the screen
                    .onSubmit(of: .search) {
                        recipeViewModel.searchRecipes(for: searchQuery) // Perform search when submitting
                    }
                }
            }
            
            .padding(.top, 52)
            
            HStack {
                Button(action: {
                    showIngredientsScreen = false
                }) {
                    Image(systemName: "chevron.backward")
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle()
                            .fill(Color.yellow)
                            .shadow(radius: 4))
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 760)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showIngredientsScreen: .constant(true),
                   showRecipeScreen: .constant(false),
                   showInstructionScreen: .constant(false))
    }
}

