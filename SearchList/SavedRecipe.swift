//
//  SavedRecipe.swift
//  SearchList
//
//  Created by Alberto Garza on 25.11.25.
//

import SwiftUI
import SwiftData

@Model
final class SavedRecipe {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: String?
    var dateSaved: Date
    
    init(id: Int?, title: String?, image: String?, imageType: String?) {
        self.id = id
        self.title = title
        self.image = image
        self.imageType = imageType
        self.dateSaved = Date()
    }
    
    // Convenience initializer from Recipe
    convenience init(from recipe: Recipe) {
        self.init(
            id: recipe.id,
            title: recipe.title,
            image: recipe.image,
            imageType: recipe.imageType
        )
    }
}
