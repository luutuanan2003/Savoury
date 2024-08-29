//
//  CategoryTabView.swift
//  Savoury
//
//  Created by Elwiz Scott on 27/8/24.
//

import SwiftUI

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
