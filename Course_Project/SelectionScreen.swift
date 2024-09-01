//
//  SelectionScreen.swift
//  Savoury
//
//  Created by Elwiz Scott on 28/8/24.
//

import SwiftUI

struct SelectionScreen: View {
    @Binding var showSelectionScreen: Bool
    @State private var selectedLetter: Character = "B"
    @State private var selectedIngredients: [String] = ["Black glutinous (sticky) rice"]
    @State private var showRecipeScreen = false
    
    let letters: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let ingredients = [
        "Baharat", "Balsamic vinegar", "Barberries", "Bay leaves",
        "Besan flour", "Black glutinous (sticky) rice", "Black pudding", "Bonito flakes"
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            if showRecipeScreen {
                RecipeScreen(showRecipeScreen: $showRecipeScreen, showSelectionScreen: $showSelectionScreen)  // Pass the bindings
            } else {
                VStack {
                    // Top navigation bar
                    HStack {
                        Button(action: {
                            showSelectionScreen = false
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
                        Text("Ingredient A-Z")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("Search")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .opacity(0.8)
                    .cornerRadius(40)
                    .padding(.horizontal)
                    
                    // Alphabet scroll
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(letters, id: \.self) { letter in
                                Text(String(letter))
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(selectedLetter == letter ? .yellow : .black)
                                    .onTapGesture {
                                        selectedLetter = letter
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Ingredients list
                    List {
                        ForEach(ingredients, id: \.self) { ingredient in
                            HStack {
                                Circle()
                                    .fill(selectedIngredients.contains(ingredient) ? Color.yellow : Color.gray.opacity(0.2))
                                    .frame(width: 20, height: 20)
                                Text(ingredient)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if selectedIngredients.contains(ingredient) {
                                    selectedIngredients.removeAll { $0 == ingredient }
                                } else {
                                    selectedIngredients.append(ingredient)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    // Bottom button
                    Button(action: {
                        showRecipeScreen = true  // Show the RecipeScreen when "Add to dish" is pressed
                    }) {
                        Text("Add to dish")
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
}

struct SelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectionScreen(showSelectionScreen: .constant(true))
    }
}
