//
//  APIConfig.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import Foundation

//struct APIConfig: Codable {
    
//    let spooncularAPIKey: String
//}

enum APIKeys {
    
    static var spoonculars: String {
        
        guard let key = Bundle.main.object(forInfoDictionaryKey: "spooncularAPIKey") as? String else {
            print("API key not found in Info.plist")
            return "DefaultKey"
        }
        return key
    }
}
