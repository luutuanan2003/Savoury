//
//  RecipeScreen.swift
//  Savoury
//
//  Created by Elwiz Scott on 28/8/24.
//

import SwiftUI

struct RecipeScreen: View {
    var recipeName: String = "Tteokbokki"
    var ingredients: [String] = ["Tomato", "Rice", "Egg", "Onion"]
    var recipeImage: String = "Tteokbokki" // Replace with the actual image name

    var body: some View {
        VStack {
            // Top navigation bar
            HStack {
                Button(action: {
                    // Back action
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().fill(Color.yellow))
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
                // Start cooking action
            }) {
                Text("Start cooking")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.yellow)
                    .cornerRadius(40)
                    .padding(.bottom, -20)
            }
            .padding()
        }
    }
}

struct RecipeScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipeScreen()
    }
}
