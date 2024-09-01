//
//  CategoryTabView.swift
//  Savoury
//
//  Created by Elwiz Scott on 27/8/24.
//

// Checked by An 1/9/24

import SwiftUI

// A SwiftUI view that displays a horizontal scrollable list of category buttons.
// Users can select a category by tapping on one of the buttons, and the selected category will be highlighted. But for now the default value is "popular" case

struct CategoryTabView: View {
    @State private var selectedCategory: Category = .popular
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(Category.allItems, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        isSelected: selectedCategory == category
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
        }
        .padding(.leading, 2)
    }
}



struct CategoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTabView()
    }
}
