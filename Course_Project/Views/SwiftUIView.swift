//
//  ContentView.swift
//  ToDoItem
//
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var add: [AddFavorite]

    var body: some View {
        NavigationStack {
            List {
                ForEach(add) { Adding in
                    HStack {
                        Text(Adding.dish)
//                        Text(Adding.recipeID)

                        Spacer()

                    }
                }
                .onDelete(perform: deleteItem)
            }

            .navigationTitle("To Do List")
            
            .toolbar {
                Button("", systemImage: "plus") {
                   
                }
            }
        }
    }
    
    // Function to handle deletion
        func deleteItem(at offsets: IndexSet) {
            for index in offsets {
                let itemToDelete = add[index]
                modelContext.delete(itemToDelete)  // Delete from the model context
            }
            try? modelContext.save()  // Commit the changes
        }
}

#Preview {
    ContentView()
        .modelContainer(for: AddFavorite.self)
}
