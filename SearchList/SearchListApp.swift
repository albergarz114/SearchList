//
//  SearchListApp.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import SwiftUI
import SwiftData

@main
struct SearchListApp: App {
    
    @State var model = RecipeModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
        }
        .modelContainer(for: SavedRecipe.self)
    }
}
