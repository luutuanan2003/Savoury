//
//  SelectionScreen.swift
//  Savoury
//
//  Created by Elwiz Scott on 28/8/24.
//

import SwiftUI

struct SelectionScreen: View {
    @State private var selectedLetter: Character = "B"  // Use Character for the selected letter
    @State private var selectedIngredients: [String] = ["Black glutinous (sticky) rice"]
    
    let letters: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let ingredients = [
        "Baharat", "Balsamic vinegar", "Barberries", "Bay leaves",
        "Besan flour", "Black glutinous (sticky) rice", "Black pudding", "Bonito flakes"
    ]
    
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
                        Text(String(letter)) // Convert Character to String
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
                // Add to dish action
            }) {
                Text("Add to dish")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.yellow)
                    .cornerRadius(45)
                    .padding(.bottom, -20)
            }
            .padding()
        }
    }
}

struct SelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectionScreen()
    }
}

