//
//  BasicTextImageRow.swift
//  Savoury
//
//  Created by An Luu on 1/9/24.
//

// Check by An 1/9/24

import SwiftUI

// A SwiftUI view that represents a row displaying a dish's image along with its name and type.
// This view is used to visually present a dish within a grid or list.

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
