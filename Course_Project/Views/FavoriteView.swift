//
//  FavoriteView.swift
//  Savoury
//
//  Created by Kien Le on 6/10/24.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Binding var showFavoriteView: Bool
    @ObservedObject var recipeSearch = RecipeSearch()
    @Query var addFavorites: [AddFavorite]  // Assuming AddFavorite contains saved URIs

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            // White background to cover the entire screen
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                // Top navigation bar
                HStack {
                    Button(action: {
                        showFavoriteView = false  // Hide TimerScreen
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                            .background(Circle()
                                .fill(Color.yellow)
                                .shadow(radius: 4))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                
                HStack {
                    Text("Your Favorite Recipes")
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
                    // Fetch the saved recipes by URI when the view appears
                    let savedURIs = addFavorites.map { $0.recipeID }
                    recipeSearch.fetchRecipesByURI(savedURIs)
                }
            }
        }
        
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(showFavoriteView: .constant(true))
    }
}
