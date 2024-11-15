//
//  RecipeSearch.swift
//  Savoury
//
//  Created by Kien Le on 26/9/24.
//

import Foundation
import SwiftData

/// ViewModel for fetching recipes from an API and managing the recipe data within an app.
class RecipeSearch: ObservableObject {
    
    /// An array to hold the search results, observable by the UI for updates.
    @Published var recipes: [RecipeHit] = []
    
    /// Computed properties to fetch the API ID and key from a static property manager.
    private var apiID: String {
        APIKeys.apiID
    }
    
    /// Function to fetch recipes with a default query "chicken". This is likely meant as a default search or example.
    private var apiKey: String {
        APIKeys.apiKey
    }
    
    // Unified method to fetch recipes based on the selected category
    func fetchRecipes(for category: Category) {
        var dishType = ""

        // Map the selected category to a corresponding dishType query parameter
        switch category {
        case .maindish:
            dishType = "Main course"
        case .salad:
            dishType = "Salad"
        case .drinks:
            dishType = "Drinks"
        case .dessert:
            dishType = "Desserts"
        }

        // Construct the base URL for the API request
        var urlString = "https://api.edamam.com/search?q=&dishType=\(dishType)&app_id=\(apiID)&app_key=\(apiKey)&from=0&to=10"

        // Access the saved healthes and diets from UserDefaults
        let savedHealth = UserDefaults.standard.array(forKey: "selectedHealth") as? [String] ?? []
        let savedDiets = UserDefaults.standard.array(forKey: "selectedDiets") as? [String] ?? []

        // Append health parameters for health
        for health in savedHealth {
            if let healthEnum = Health.allCases.first(where: { $0.description == health }) {
                urlString += "&health=\(healthEnum.apiValue)"
            }
        }

        // Append health parameters for diets
        for diet in savedDiets {
            if let dietEnum = Diet.allCases.first(where: { $0.description == diet }) {
                urlString += "&diet=\(dietEnum.apiValue)"
            }
        }

        // Ensure the URL is valid
        guard let url = URL(string: urlString) else { return }

        // URLSession to handle the API network request.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    // Decode the JSON data into RecipeResponse model
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    // Ensure UI updates happen on the main thread
                    DispatchQueue.main.async {
                        // Update the published recipes array
                        self.recipes = decodedResponse.hits
                    }
                    print("API Request URL: \(urlString)")
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume() // Start the network task
    }
    
    /// Fetches the recipe details for a list of URIs.
    func fetchRecipesByURI(_ uris: [String]) {
        // Clear any existing recipes
        self.recipes.removeAll()

        for uri in uris {
            // Extract the recipe ID from the URI (after "recipe_" part)
            guard let recipeID = uri.split(separator: "_").last else {
                print("Invalid URI format: \(uri)")
                continue
            }

            // Construct the URL
            let urlString = "https://api.edamam.com/api/recipes/v2/\(recipeID)?type=public&app_id=\(apiID)&app_key=\(apiKey)"
            guard let url = URL(string: urlString) else { return }

            // Make the API request
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        // Decode the JSON response directly into a Recipe object (no hits array)
                        let decodedRecipe = try JSONDecoder().decode(RecipeHit.self, from: data)
                        DispatchQueue.main.async {
                            // Append the fetched recipe to the list
                            self.recipes.append(decodedRecipe)
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                }
            }.resume()
        }
    }

    /// Function to search recipes based on a custom ingredient.
    func searchRecipes(for ingredient: String) {
        let query = ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.edamam.com/search?q=\(query)&app_id=\(apiID)&app_key=\(apiKey)&from=0&to=10"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.hits
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
    
    /// Function to search recipes based on multiple selected ingredients
    func searchRecipes(forSelectedIngredients selectedIngredients: [String]) {
        guard !selectedIngredients.isEmpty else { return }
        let query = selectedIngredients.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.edamam.com/search?q=\(query)&app_id=\(apiID)&app_key=\(apiKey)&from=0&to=10"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes.append(contentsOf: decodedResponse.hits)  // Append to the existing list of recipes
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
    
    /// Function to clear recipes before a new search
    func clearRecipes() {
        recipes.removeAll()
    }
}


/// Create a model to parse API response
struct RecipeResponse: Decodable {
    let hits: [RecipeHit]
}

/// Represents a single search result item.
struct RecipeHit: Decodable, Identifiable {
    let id = UUID()
    let recipe: Recipe
}

/// Detailed model for a recipe.
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let yield: Double?               // Optional, number of servings
    let calories: Double?            // Optional, total calories
    let totalWeight: Double?         // Optional, total weight of the recipe
    let totalTime: Double?           // Optional, total time in minutes
    let cautions: [String]?          // Optional, list of cautions (e.g., allergies)
    let ingredients: [Ingredient]?   // List of ingredients
    let cuisineType: [String]?       // Optional, list of cuisine types (e.g., "American")
    let mealType: [String]?          // Optional, list of meal types (e.g., "Dinner")
    let dishType: [String]?          // Optional, list of dish types (e.g., "Main course")
    let url: String?                 // URL to the original recipe with instructions
}

/// Ingredient model represents individual ingredients within a recipe.
struct Ingredient: Decodable {
    let food: String  // Ingredient name
}

/// APIKeys struct provides a mechanism to securely fetch and store API keys from a local plist file.
struct APIKeys {
    
    /// Static properties fetch the keys on demand.
    static var apiID: String {
        getValueFromAPI(for: "API_ID")
    }
    
    /// Static properties fetch the keys on demand.
    static var apiKey: String {
        getValueFromAPI(for: "API_KEY")
    }
    
    /// Helper function to get values from the plist file.
    static func getValueFromAPI(for key: String) -> String {
        if let path = Bundle.main.path(forResource: "API", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            return dict[key] as? String ?? ""
        }
        return ""
    }
}
