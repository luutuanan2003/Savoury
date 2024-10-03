//
//  HomeView.swift
//  Savoury
//
//  Created by An Luu on 22/8/24.
//  Modified by Kien Le 30/8/24
//  Check by An Luu 1/9/24

import SwiftUI

///The main screen view of the application, providing an overview of various dishes, navigation through categories, and access to different sections like the recipe and cooking mode screens.
struct HomeView: View {
    
    /// This username value is passed in by the authentication process
    @State var username: String

    
    @State private var selectedCategory: Category = .maindish  // Default to "Main Dishes"
    
    /// State to control the visibility of the  screens
    @State private var showCulinaryPreferencesView = false
    @State private var showIngredientsScreen = false
    @State private var showRecipeScreen = false
    @State private var showInstructionScreen = false
    @State private var showTimerScreen = false
    @State private var fromInstructionScreen = false
    
    
    // Observed RecipeSearch for Popular recipes
        @ObservedObject var recipeSearch = RecipeSearch()
    
    // Layout configuration for displaying dishes in a grid with flexible columns.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    // instead of saying welcome home, it will said welcome username
                    Text("Welcome, \(username)!")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    Image(systemName: "person.crop.circle")
                        .padding(.horizontal)
                        .onTapGesture {
                            showCulinaryPreferencesView = true
                        }
                }
                .padding()
                
                // CategoryTab for selection
                CategoryTab(selectedCategory: $selectedCategory, recipeSearch: recipeSearch)

                // Conditionally show views based on selected category
                if selectedCategory == .maindish {
                    MainDishView()
                } else if selectedCategory == .dessert {
                    DessertView()
                } else if selectedCategory == .salad {
                    SaladView()
                } else if selectedCategory == .drinks {
                    DrinkView()
                }
                
                // Using the TabBarView for navigating to other parts of the application.
                TabBar(
                    showIngredientsScreen: $showIngredientsScreen,
                    showTimerScreen: $showTimerScreen)
            }
            
                    
            // Conditionally display the selected screen if @State variable above is true.

            if showCulinaryPreferencesView{
                CulinaryPreferencesView(showCulinaryPreferencesView: $showCulinaryPreferencesView, userName_homeview: $username)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            
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
        HomeView(username: "Dummy")
    }
}
