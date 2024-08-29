//
//  CategoryButton.swift
//  Course_Project
//
//  Created by Elwiz Scott on 24/8/24.
//

import SwiftUI

struct CategoryButton: View {
    
    let category: Category
    
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                        // No action here
                    }) {
                        Image(systemName: category.categorySymbol)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34) // Size of the flame symbol
                            .padding(30)
                            
                            .foregroundColor(isSelected ? .black : .gray)
                            .background(RoundedRectangle(cornerRadius: 45) // Rounded rectangle with circular radius
                                .fill(isSelected ? Color.yellow : Color.gray.opacity(0.1)) // Yellow background color
                                .frame(width: 74, height: 84))
                    }
            Text(category.categoryName)
                
                .bold()
                .font(.footnote)
                .foregroundColor(isSelected ? .black : .gray)
        }
    }
}


struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(category: .popular, isSelected: true)
    }
}
