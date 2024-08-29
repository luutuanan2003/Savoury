//
//  HomeScreen.swift
//  a1-s3926655
//
//  Created by An Luu on 22/8/24.
//

import SwiftUI


struct HomeScreen: View {
    
    @State var dishes = [
        Dish(name: "Nasi Lemak", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak1", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak2", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"]),
        Dish(name: "Nasi Lemak3", type: "Main Dish", image: "Nasi Lemak", isFavorite: false, ingredients: ["Egg", "Rice", "Sambal", "Cucumber", "Anchovie"])]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack {
            HStack{
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
            
            Rectangle().fill(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255)).frame(width: .infinity, height: 1, alignment: .center)
            HStack{
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
                                        .frame(width: 160, height: 200) // Adjusted the frame to fit the layout
                                }
                            }
                            .padding(.horizontal)
            }
            
            .frame(height: 430) // Extend the height of the ScrollView
            
            TabBarView()
        }
    }
}
    
struct BasicTextImageRow: View {
    
    // MARK: - Binding
    
    @Binding var dish: Dish
    
    var body: some View {
        VStack{
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
