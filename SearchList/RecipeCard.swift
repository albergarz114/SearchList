//
//  RecipeCard.swift
//  SearchList
//
//  Created by Alberto Garza on 25.11.25.
//
// Control + Command + Space -> for emojis
import Foundation
import SwiftUI
import SwiftData

// API Recipe Card
struct APIRecipeCard: View {
    let recipe: Recipe
    let onSave: () -> Void
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: recipe.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(10)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 120)
                    .cornerRadius(10)
                    .overlay(ProgressView())
            }
            
            Text(recipe.title ?? "No Title")
                .font(.headline)
                .lineLimit(2)
                .padding(.horizontal, 8)
            
            Button("Save") {
                onSave()
            }
            .buttonStyle(.bordered)
            .tint(.green)
            
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}


// Saved Recipe Card
struct SavedRecipeCard: View {
    
    let savedRecipe: SavedRecipe
    let onUpdate: (() -> Void)?
    let onDelete: (() -> Void)?
   
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: savedRecipe.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(10)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 120)
                    .cornerRadius(10)
                    .overlay(ProgressView())
            }
            
            Text(savedRecipe.title ?? "No Title")
                .font(.headline)
                .lineLimit(2)
                .padding(.horizontal, 8)
            
            // STEP 1: Add Update button
            
            if let onUpdate = onUpdate {
                VStack {
                    Button("Update") {
                        onUpdate()
                    }
                }
                .buttonStyle(.bordered)
                .font(.caption)
                .tint(.black)
            }
            
            if let onDelete = onDelete {
                VStack {
                    Button("Delete") {
                        onDelete()
                    }
                }
                
                .buttonStyle(.automatic)
                .font(.caption)
                .tint(.black)
            }
            
        }
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}
