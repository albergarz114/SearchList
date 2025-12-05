//
//  RecipeListsTests.swift
//  RecipeListsTests
//
//  Created by Alberto Garza on 30.11.25.
//

import XCTest
import SwiftData
@testable import SearchList

@MainActor
final class RecipeListsTests: XCTestCase {
    
    private var repository: RecipeRepository!
    
    override func setUp() {
        
        super.setUp()
        
        let container = try! ModelContainer(for: SavedRecipe.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let modelContext = ModelContext(container)
        repository = RecipeRepository(modelContext: modelContext)
    }
    
    override func tearDown() {
        
        repository = nil
        
        super.tearDown()
    }
    
    // Save Recipe Tests
    func testSaveRecipe_InsertsIntoContext() {
        
        // Given
        let recipes = Recipe(
            id: 1,
            title: "Test Title",
            image: "test.jpg",
            imageType: "jpg"
        )
        
        // When
        repository.saveRecipe(recipes)
        
        // Then
        let savedRecipes = repository.fetchAllSavedRecipes()
        XCTAssertEqual(savedRecipes.count, 1)
        XCTAssertEqual(savedRecipes.first?.title, "Test Title")
    }
    
    
    // Fetch All news Tests
    func testFetchAllSavedRecipes_ReturnsEmptyArray() {
        
        // When
        let result = repository.fetchAllSavedRecipes()
        
        // Then
        XCTAssertTrue(result.isEmpty)
    }
    
    
    func testFetchAllSavedRecipes_ReturnsSavedRecipes() {
        // Given
        let recipes = Recipe(
            id: 1,
            title: "Test Recipe",
            image: "test.jpg",
            imageType: "jpg"
        )
        repository.saveRecipe(recipes)
        
        // When
        let result = repository.fetchAllSavedRecipes()
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Test Recipe")
    }
    
    
    func testDeleteNews_RemovesFromContext() {
        // Given
        let recipes = Recipe(
            id: 1,
            title: "Test Recipe",
            image: "test.jpg",
            imageType: "jpg"
        )
        repository.saveRecipe(recipes)
        let savedRecipes = repository.fetchAllSavedRecipes().first!
        
        // When
        repository.deleteRecipes(savedRecipes)
        
        // Then
        let result = repository.fetchAllSavedRecipes()
        XCTAssertTrue(result.isEmpty)
    }
    
    func testDeleteAllNews_RemovesAllItems() {
        
        // Given
        let recipes1 = Recipe(
            id: 1,
            title: "Test Recipe 1",
            image: "test.jpg",
            imageType: "jpg"
        )
        let recipes2 = Recipe(
            id: 2,
            title: "Test Recipe 2",
            image: "test.jpg",
            imageType: "jpg2"
        )
        repository.saveRecipe(recipes1)
        repository.saveRecipe(recipes2)
        
        // When
        repository.deleteAllRecipes()
        
        // Then
        let result = repository.fetchAllSavedRecipes()
        XCTAssertTrue(result.isEmpty)
    }
    
    func testStartRecipe_AddStarToTitle() {
        let recipes = Recipe(
            id: 1,
            title: "Test Recipe",
            image: "test.jpg",
            imageType: "jpg"
        )
        repository.saveRecipe(recipes)
        let savedRecipes = repository.fetchAllSavedRecipes().first!
        // When
        repository.starRecipes(savedRecipes)
        
        // Then
        let updatedRecipes = repository.fetchAllSavedRecipes().first!
        XCTAssertEqual(updatedRecipes.title, "⭐Test Recipe")
    }
    
    
    func testStarsRecipes_WithNilTitle() {
        
        let recipes = Recipe(
            id: 1,
            title: nil,
            image: "test.jpg",
            imageType: "jpg"
        )
        repository.saveRecipe(recipes)
        let savedRecipes = repository.fetchAllSavedRecipes().first!
        
        repository.starRecipes(savedRecipes)
        
        let updatedRecipes = repository.fetchAllSavedRecipes().first!
        XCTAssertEqual(updatedRecipes.title, "⭐No Title")
    }
    
}
