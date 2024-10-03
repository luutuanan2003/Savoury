//
//  RecipeSearch.swift
//  Savoury
//
//  Created by Elwiz Scott on 26/9/24.
//

import Foundation

// ViewModel for fetching recipes
class RecipeSearch: ObservableObject {
    @Published var recipes: [RecipeHit] = []
    
    private var apiID: String {
        APIKeys.apiID
    }
        
    private var apiKey: String {
        APIKeys.apiKey
    }
    
    func fetchRecipes() {
        let urlString = "https://api.edamam.com/search?q=chicken&app_id=\(apiID)&app_key=\(apiKey)&from=0&to=10"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.hits
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchMainDish() {
        let urlString = "https://api.edamam.com/search?q=&dishType=Main course&app_id=\(apiID)&app_key=\(apiKey)&from=2&to=12"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.hits
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchSalad() {
        let urlString = "https://api.edamam.com/search?q=&dishType=Salad&app_id=\(apiID)&app_key=\(apiKey)&from=2&to=12"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.hits
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchDrinks() {
        let urlString = "https://api.edamam.com/search?q=&dishType=Drinks&app_id=\(apiID)&app_key=\(apiKey)&from=2&to=12"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.hits
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchDessert() {
        let urlString = "https://api.edamam.com/search?q=&dishType=Desserts&app_id=\(apiID)&app_key=\(apiKey)&from=0&to=10"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.hits
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
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
    
    // Function to search recipes based on multiple selected ingredients
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
    
    // Function to clear recipes before a new search
    func clearRecipes() {
        recipes.removeAll()
    }
}


// Create a model to parse API response
struct RecipeResponse: Decodable {
    let hits: [RecipeHit]
}

struct RecipeHit: Decodable, Identifiable {
    let id = UUID()
    let recipe: Recipe
}

struct Recipe: Decodable {
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

struct Ingredient: Decodable {
    let food: String  // Ingredient name
}


struct APIKeys {
    static var apiID: String {
        getValueFromAPI(for: "API_ID")
    }
    
    static var apiKey: String {
        getValueFromAPI(for: "API_KEY")
    }
    
    static func getValueFromAPI(for key: String) -> String {
        if let path = Bundle.main.path(forResource: "API", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            return dict[key] as? String ?? ""
        }
        return ""
    }
}
