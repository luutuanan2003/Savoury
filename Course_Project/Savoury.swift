//
//  Savoury.swift
//  Savoury
//
//  Created by Kien Le on 24/8/24.
//

// Checked by An 1/9/24

import SwiftUI

@main
struct Savoury: App {
    var body: some Scene {
        WindowGroup {
            // DO NOT DELETE COMMENT THIS IS FOR TESTING THE MODEL
//            CulinaryPreferencesView(showCulinaryPreferencesView: .constant(true))
//            HomeView()
            UserAuthenticationView()
        }
    }
}
