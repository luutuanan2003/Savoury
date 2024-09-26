//
//  SearchView.swift
//  Savoury
//
//  Created by Elwiz Scott on 26/9/24.
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
    
    // For grid layout similar to home screen
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // White background to cover the entire screen
            VStack {
                // Top navigation bar
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
                
                // Title
                HStack {
                    Text("Search Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search for ingredients", text: $searchQuery, onCommit: {
                        recipeViewModel.searchRecipes(for: searchQuery)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(40)
                .padding(.horizontal)
                
                // ScrollView with LazyVGrid for a grid layout
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
                
                Spacer()
                
                // Bottom button
//                Button(action: {
//                    
//                }) {
//                    Text("Go to Recipe")
//                        .font(.system(size: 18, weight: .bold))
//                        .foregroundColor(.black)
//                        .padding(.horizontal, 30)
//                        .padding(.vertical, 10)
//                        .background(Capsule()
//                            .fill(Color.yellow)
//                            .frame(height: 50)
//                            .shadow(radius: 4))
//                }
//                .padding()
            }
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
