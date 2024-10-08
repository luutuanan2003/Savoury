//
//  RecipeWidgetBundle.swift
//  RecipeWidget
//
//  Created by Kien Le on 8/10/24.
//

import WidgetKit
import SwiftUI

@main
struct RecipeWidgetBundle: WidgetBundle {
    var body: some Widget {
        RecipeWidget()
        RecipeWidgetLiveActivity()
    }
}
