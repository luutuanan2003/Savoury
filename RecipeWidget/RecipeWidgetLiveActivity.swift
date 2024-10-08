//
//  RecipeWidgetLiveActivity.swift
//  RecipeWidget
//
//  Created by Kien Le on 8/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RecipeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RecipeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RecipeWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RecipeWidgetAttributes {
    fileprivate static var preview: RecipeWidgetAttributes {
        RecipeWidgetAttributes(name: "World")
    }
}

extension RecipeWidgetAttributes.ContentState {
    fileprivate static var smiley: RecipeWidgetAttributes.ContentState {
        RecipeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RecipeWidgetAttributes.ContentState {
         RecipeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RecipeWidgetAttributes.preview) {
   RecipeWidgetLiveActivity()
} contentStates: {
    RecipeWidgetAttributes.ContentState.smiley
    RecipeWidgetAttributes.ContentState.starEyes
}
