//
//  HomeScreen.swift
//  a1-s3926655
//
//  Created by An Luu on 22/8/24.
// Modified by Kien 30/8/24
// Check by An 1/9/24

import SwiftUI

///The main screen view of the application, providing an overview of various dishes, navigation through categories, and access to different sections like the recipe and cooking mode screens.
struct HomeView: View {
    
    /// State to control the visibility of the  screens
    @State private var showIngredientsScreen = false
    @State private var showRecipeScreen = false
    @State private var showInstructionScreen = false
    @State private var showTimerScreen = false
    @State private var fromInstructionScreen = false

    /// List of dishes to display on the home screen.
    @State var dishes = [
        Dish(name: "Nasi Lemak", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak1", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak2", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak3", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"])
    ]
    
    // Layout configuration for displaying dishes in a grid with flexible columns.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Welcome Home")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    Image(systemName: "person.crop.circle")
                        .padding(.horizontal)
                }
                .padding()
                
                CategoryTab()
                
                HStack {
                    Text("Top dishes of the day")
                        .font(.title)
                        .fontWeight(.black)
                        .padding()
                    Spacer()
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach($dishes, id: \.self) { $dish in
                            // Using the BasicTextImageRow view
                            BasicTextImageRow(dish: $dish)
                                .frame(width: 160, height: 200)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 430)
                
                
                // Using the TabBarView for navigating to other parts of the application.
                TabBar(
                    showIngredientsScreen: $showIngredientsScreen,
                    showTimerScreen: $showTimerScreen)
            }
            
            // Conditionally display the selected screen if @State variable above is true.
            
            if showIngredientsScreen {
                IngredientsView(
                    showIngredientsScreen: $showIngredientsScreen,
                    showRecipeScreen: $showRecipeScreen,
                    showInstructionScreen: $showInstructionScreen)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            
            if showRecipeScreen {
                RecipeView(
                    showIngredientsScreen: $showIngredientsScreen,
                    showRecipeScreen: $showRecipeScreen,
                    showInstructionScreen: $showInstructionScreen)
                    .transition(.move(edge: .leading))
                    .zIndex(2)
            }
            
            if showInstructionScreen {
                InstructionView(
                    showInstructionScreen: $showInstructionScreen,
                    showRecipeScreen: $showRecipeScreen,
                    showTimerScreen: $showTimerScreen,
                    fromInstructionScreen: $fromInstructionScreen)  // Pass the state for TimerScreen launch source
                    .transition(.move(edge: .leading))
                    .zIndex(3)
            }
            
            if showTimerScreen {
                TimerView(
                    isTimerViewVisible: $showTimerScreen,
                    fromInstructionScreen: $fromInstructionScreen)  // Pass the state to TimerScreen
                    .transition(.move(edge: .leading))
                    .zIndex(4)  // Ensure TimerScreen is on top
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
