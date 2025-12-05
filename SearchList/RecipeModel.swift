//
//  RecipeModel.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import Foundation
import SwiftUI

@Observable
class RecipeModel {
    
    var recipes: [Recipe] = []
    var selectedRecipe: Recipe?
    var service = DataService()
    
    func fetchRecipes(query: String?, diet: String?, intolerances: String?, excludeCuisine: String?, sort: String?, number: Int?) {
        Task {
            recipes = await service.recipeSearch(query: query, diet: diet, intolerances: intolerances, excludeCuisine: excludeCuisine, sort: sort, number: number)
        }
    }
}
