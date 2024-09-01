//
//  HomeScreen.swift
//  a1-s3926655
//
//  Created by An Luu on 22/8/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showSelectionScreen = false
    @State var dishes = [
        Dish(name: "Nasi Lemak", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak1", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak2", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak3", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"])
    ]
    
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
                
                CategoryTabView()
                
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
                            BasicTextImageRow(dish: $dish)
                                .frame(width: 160, height: 200)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 430)
                
                TabBarView(showSelectionScreen: $showSelectionScreen)
            }
            
            if showSelectionScreen {
                SelectionScreen(showSelectionScreen: $showSelectionScreen)
//                    .transition(.move(edge: .trailing))
//                    .zIndex(1)
            }
        }
    }
}

struct BasicTextImageRow: View {
    @Binding var dish: Dish
    
    var body: some View {
        VStack {
            Image(dish.image)
                .resizable()
                .frame(width: 140, height: 140)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(dish.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(dish.type)
                    .font(.system(.body, design: .rounded))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
