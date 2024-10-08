//
//  RecipeWidget.swift
//  RecipeWidget
//
//  Created by Kien Le on 8/10/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), recipe: Recipe.placeholder())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), recipe: Recipe.placeholder())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        // Generate a timeline with one entry every hour.
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, recipe: Recipe.placeholder())

        // Timeline updates every hour
        let timeline = Timeline(entries: [entry], policy: .after(currentDate.addingTimeInterval(3600)))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let recipe: Recipe
}

struct RecipeWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                // Recipe Image
                if let imageUrl = URL(string: entry.recipe.image) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .cornerRadius(8)
                    } placeholder: {
                        Color.gray.frame(width: 150, height: 150)
                    }
                }

                // Recipe Title and Cuisine Type
                VStack(alignment: .leading) {
                    Text(entry.recipe.label)
                        .font(.headline)
                        .bold()
                    if let cuisineType = entry.recipe.cuisineType?.first {
                        Text(cuisineType)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 8)
                .border(Color.black)

                Spacer()
            }
            // Horizontal Capsule Layout for details (Time, Servings, Calories, Weight)
            HStack(spacing: 10) {
                RecipeDetailCapsule(iconName: "clock", label: "Time", value: "\(Int(entry.recipe.totalTime))", unit: "mins")
                RecipeDetailCapsule(iconName: "person.2.fill", label: "Servings", value: "\(Int(entry.recipe.yield))", unit: "Servings")
                RecipeDetailCapsule(iconName: "flame.fill", label: "Calories", value: "\(Int(entry.recipe.calories))", unit: "Cal")
                RecipeDetailCapsule(iconName: "square.stack.3d.up.fill", label: "Weight", value: "\(Int(entry.recipe.totalWeight))", unit: "Gram")
            }

            .padding(.vertical, 5)
        }
        .padding()
//        .padding(.bottom, -100)
        .containerBackground(Color.white, for: .widget)
    }
}


struct RecipeWidget: Widget {
    let kind: String = "RecipeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RecipeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Recipe Details")
        .description("View recipe details at a glance.")
        .supportedFamilies([.systemLarge])
    }
}


extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

struct Recipe: Identifiable {
    var id = UUID()
    var label: String
    var image: String
    var totalTime: Double
    var yield: Double
    var calories: Double
    var totalWeight: Double
    var cuisineType: [String]?

    static func placeholder() -> Recipe {
        return Recipe(label: "Bimbimbap",
                      image: "https://www.allrecipes.com/thmb/ewSWaXqsw97lWyAWek_u9fguJ3g=/0x512/filters:no_upscale():max_bytes(150000):strip_icc()/Easyspaghettiwithtomatosauce_11715_DDMFS_4x3_2424-8d7bf30b2622465f9dd78a2c6277eeb8.jpg",
                      totalTime: 25,
                      yield: 4,
                      calories: 500,
                      totalWeight: 800,
                      cuisineType: ["Asian"]
        )
    }
}

struct RecipeDetailCapsule: View {
    var iconName: String
    var label: String
    var value: String
    var unit: String

    var body: some View {
        ZStack {
            Capsule()
                .frame(width: 70, height: 120)
                .foregroundColor(.yellow)
            VStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .padding(.top, -10)
                    .padding(.bottom, 5)
                    .overlay(
                        Image(systemName: iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                            .padding(.top, -15)
                    )
                Text(value)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                Text(unit)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
            }
        }
    }
}


#Preview(as: .systemLarge) {
    RecipeWidget()
} timeline: {
    SimpleEntry(date: .now, recipe: Recipe.placeholder())
}
