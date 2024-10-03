//
//  RecipeDetailView.swift
//  Savoury
//
//  Created by Kien Le on 27/9/24.
//

import SwiftUI
import UIKit

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    // Recipe Image
                    if let imageUrl = URL(string: recipe.image) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(.vertical, 30)
                                .frame(width: UIScreen.main.bounds.width, height: 300)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Button(action: {
                        // Action for the save or bookmark functionality
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .shadow(radius: 4)
                            
                            Image(systemName: "bookmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                        }
                        
                    }
                    .padding(.leading, 300)
                    .padding(.bottom, 200)
                }
                
                // Recipe Title and Rating (Example Rating Placeholder)
                HStack {
                    Text(recipe.label)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                if let cuisineType = recipe.cuisineType, !cuisineType.isEmpty {
                    Text("\(cuisineType.joined(separator: ", "))")
                        .font(.title3)
                        .padding(.horizontal)
                        .padding(.top, -10)
                        .foregroundColor(.gray)
                }

                // Capsules for Total Time, Servings, Calories, Total Weight
                HStack {
                    HStack {
                        Spacer()

                        // Capsule for Total Time
                        if let totalTime = recipe.totalTime {
                            ZStack {
                                Capsule()
                                    .frame(width: 70, height: 120)
                                    .foregroundColor(.yellow)
                                VStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                        .padding(.top, -10)
                                        .padding(.bottom, 5)
                                        .overlay(
                                            Image(systemName: "clock")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                                .padding(.top, -15)
                                        )
                                    Text("\(Int(totalTime))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                    Text("mins")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                        }

                        Spacer()

                        // Capsule for Servings
                        if let yield = recipe.yield {
                            ZStack {
                                Capsule()
                                    .frame(width: 70, height: 120)
                                    .foregroundColor(.yellow)
                                VStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                        .padding(.top, -10)
                                        .padding(.bottom, 5)
                                        .overlay(
                                            Image(systemName: "person.2.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                                .padding(.top, -15)
                                        )
                                    Text("\(Int(yield))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                    Text("Servings")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                        }

                        Spacer()

                        // Capsule for Calories
                        if let calories = recipe.calories {
                            ZStack {
                                Capsule()
                                    .frame(width: 70, height: 120)
                                    .foregroundColor(.yellow)
                                VStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                        .padding(.top, -10)
                                        .padding(.bottom, 5)
                                        .overlay(
                                            Image(systemName: "flame.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                                .padding(.top, -15)
                                        )
                                    Text("\(Int(calories))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                    Text("Cal")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                        }

                        Spacer()

                        // Capsule for Total Weight
                        if let totalWeight = recipe.totalWeight {
                            ZStack {
                                Capsule()
                                    .frame(width: 70, height: 120)
                                    .foregroundColor(.yellow)
                                VStack {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                        .padding(.top, -10)
                                        .padding(.bottom, 5)
                                        .overlay(
                                            Image(systemName: "square.stack.3d.up.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                                .padding(.top, -15)
                                        )
                                    Text("\(Int(totalWeight))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                    Text("Gram")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                        }

                        Spacer()
                    }
                }
                .padding()
                
                // Ingredients
                if let ingredients = recipe.ingredients {
                    Text("Ingredients")
                        .font(.system(.title3, weight: .bold))
                        .padding(.horizontal)
                    
                    ForEach(ingredients, id: \.food) { ingredient in
                        HStack {
                            Text("•")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                                .padding(.leading)
                            Text("\(ingredient.food)")
                                .font(.body)
                        }
                        .padding(.vertical, -10)
                        
                    }
                }
                
                Spacer()

                // Optional additional sections (Cautions, Cuisine Type, etc.)
                if let cautions = recipe.cautions, !cautions.isEmpty {
                    Text("Cautions: \(cautions.joined(separator: ", "))")
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
                
                if let url = recipe.url {
                    Text("View Recipe Instructions")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .underline()
                        .padding(.horizontal)
                        .onTapGesture {
                            // Add print statement or visual feedback for debugging
                            print("Link tapped: \(url)")
                            
                            // Open the link in the default browser
                            if let recipeURL = URL(string: url) {
                                UIApplication.shared.open(recipeURL)
                            }
                        }
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
                dishType: ["Main course"], 
                url: "https://honestcooking.com/spring-strawberry-pea-salad-chicken/"
            )
        )
    }
}
