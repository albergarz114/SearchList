//
//  RecipeSearch.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import Foundation

struct RecipeResponse: Decodable {
    var offset: Int
    var number: Int
    var results: [Recipe] = []
    var totalResults: Int
}

struct Recipe: Codable, Identifiable {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: String?
}
