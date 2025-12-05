//
//  RecipeRepository.swift
//  SearchList
//
//  Created by Alberto Garza on 30.11.25.
//

import Foundation
import SwiftUI
import SwiftData


@MainActor
final class RecipeRepository {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // Create
    func saveRecipe(_ recipes: Recipe) {
        let savedRecipe = SavedRecipe(from: recipes)
        modelContext.insert(savedRecipe)
        saveContext()
    }
    
    // Read
    func fetchAllSavedRecipes() -> [SavedRecipe] {
        let descriptor = FetchDescriptor<SavedRecipe>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    // Update
    func updateRecipes(_ recipes: SavedRecipe, newTitle: String? = nil, ) {
        if let newTitle = newTitle {recipes.title = newTitle}
        saveContext()
    }
    
    // Update with star prefix
    func starRecipes(_ recipes: SavedRecipe) {
        recipes.title = "⭐\(recipes.title ?? "No Title")"
        saveContext()
    }
    
    // Delete
    func deleteRecipes(_ recipes: SavedRecipe) {
        modelContext.delete(recipes)
        saveContext()
    }
    
    // Delete all
    func deleteAllRecipes() {
        let allRecipes = fetchAllSavedRecipes()
        for recipe in allRecipes {
            modelContext.delete(recipe)
        }
        saveContext()
    }
    
    private func saveContext() {
        try? modelContext.save()
    }
}
