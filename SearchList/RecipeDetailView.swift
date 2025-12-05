//
//  RecipeDetailView.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @Environment(RecipeModel.self) var model
    
    var body: some View {
        
        let recipe = model.selectedRecipe
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.72, green: 0.64, blue: 0.98), // lavender
                Color(red: 0.53, green: 0.78, blue: 0.98), // sky-mint
                Color(red: 0.95, green: 0.90, blue: 0.99)
            ]), startPoint: .topLeading  , endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            HStack {
                ScrollView {
                    VStack {
                        Text("Recipe Information")
                            .font(Font.largeTitle.bold())
                            .foregroundColor(Color.white)
                        
                        AsyncImage(url: URL(string: recipe?.image ?? "")) { image in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                        
                        Spacer()
                        Text(recipe?.title ?? "")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    RecipeDetailView()
}
