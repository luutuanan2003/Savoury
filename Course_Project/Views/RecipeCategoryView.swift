//
//  RecipeCategoryView.swift
//  Savoury
//
//  Created by Kien Le on 4/10/24.
//

import SwiftUI

struct RecipeCategoryView: View {
    
    @ObservedObject var recipeSearch: RecipeSearch
    @Binding var selectedCategory: Category
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Top dishes of the day")
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                Spacer()
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(recipeSearch.recipes, id: \.id) { recipeHit in
                        ImageDishView(recipe: recipeHit.recipe)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                // Fetch recipes for the selected category when the view appears
                recipeSearch.clearRecipes()
                recipeSearch.fetchRecipes(for: selectedCategory)
            }
            .onChange(of: selectedCategory) {
                // Fetch recipes whenever the selected category changes
                recipeSearch.clearRecipes()
                recipeSearch.fetchRecipes(for: selectedCategory)
            }
        }
    }
}


//#Preview {
//    RecipeCategoryView()
//}
