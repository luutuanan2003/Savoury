//
//  RecipeScreen.swift
//  Savoury
//
//  Created by Elwiz Scott on 28/8/24.
//
// Check by An 1/9/24

import SwiftUI

// A SwiftUI view for displaying the details of a selected recipe, including its name, ingredients, and an image.
// Users can view the recipe and start cooking from this screen.

struct RecipeScreen: View {
    
    // Binding to control the visibility of the other screens
    @Binding var showSelectionScreen: Bool
    @Binding var showRecipeScreen: Bool
    @Binding var showCookingModeScreen: Bool
    
    // The name of the recipe, its ingredients and its image being displayed.
    var recipeName: String = "Tteokbokki"
    var ingredients: [String] = ["Tomato", "Rice", "Egg", "Onion"]
    var recipeImage: String = "Tteokbokki"

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // White background to cover the entire screen
            
            VStack {
                // Top navigation bar
                HStack {
                    Button(action: {
                        showRecipeScreen = false  // Hide RecipeScreen
                        showSelectionScreen = true  // Go back to SelectionScreen
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
                .padding(.leading)
                
                // Title
                HStack {
                    Text("Recipes")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Recipe Card
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading) {
                        Image(recipeImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .cornerRadius(20)
                        
                        Text(recipeName)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Text("Ingredients:")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 4)
                        
                        VStack(alignment: .leading) {
                            ForEach(ingredients, id: \.self) { ingredient in
                                Text(ingredient)
                                    .padding(.horizontal)
                                    .padding(.top, 2)
                            }
                        }
                        .padding(.bottom)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
                .padding(.horizontal)
                
                Spacer()
                
                // Bottom button
                Button(action: {
                    showRecipeScreen = false  // Hide RecipeScreen
                    showCookingModeScreen = true  // Show CookingModeScreen
                }) {
                    Text("Start cooking")
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

            }
        }
    }
}

struct RecipeScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipeScreen(showSelectionScreen: .constant(false), showRecipeScreen: .constant(true), showCookingModeScreen: .constant(false))
    }
}
