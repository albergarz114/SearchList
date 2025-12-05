//
//  DataService.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import Foundation

struct DataService {
    
    func recipeSearch(query: String? = nil, diet: String? = nil, intolerances: String? = nil, excludeCuisine: String? = nil, sort: String? = nil, number: Int? = nil) async -> [Recipe] {
        
        var urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")!
        
        var queryItems = [URLQueryItem(name: "apiKey", value: APIKeys.spoonculars)]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        
        if let diet = diet {
            queryItems.append(URLQueryItem(name: "diet", value: diet))
        }
        
        if let intolerances = intolerances {
            queryItems.append(URLQueryItem(name: "intolerances", value: intolerances))
        }
        
        if let excludeCuisine = excludeCuisine {
            queryItems.append(URLQueryItem(name: "excludeCuisine", value: excludeCuisine))
        }
        
        if let sort = sort {
            queryItems.append(URLQueryItem(name: "sort", value: sort))
        }
        
        if let number = number {
            queryItems.append(URLQueryItem(name: "number", value: "\(number)"))
        }
        
        urlComponents.queryItems = queryItems
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            //request.addValue(APIKeys.spoonculars, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // DEBUG
                print("RAW JSON: \(String(data: data, encoding: .utf8) ?? "No data"))")
                
                _ = JSONDecoder()
                
                do {
                    let jsonString = String(data: data, encoding: .utf8)
                        print("Raw JSON: \(jsonString ?? "Unable to decode")")
                    let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    
                    return recipeResponse.results
                } catch {
                    print("Decorating error: \(error)")
                    return []
                }
            } catch {
                print("Network error: \(error)")
                return []
            }
        }
        return []
    }
}
