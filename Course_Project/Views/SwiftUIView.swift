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

                        Spacer()

                    }
                }
            }

            .navigationTitle("To Do List")
            
            .toolbar {
                Button("", systemImage: "plus") {
                   
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: AddFavorite.self)
}
