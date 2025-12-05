import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(RecipeModel.self) var model
    @Environment(\.modelContext) private var modelContext
    @Query private var savedRecipes: [SavedRecipe]
    @State private var repository: RecipeRepository?
    @State private var showSaved = false
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.72, green: 0.64, blue: 0.98), // lavender
                Color(red: 0.53, green: 0.78, blue: 0.98), // sky-mint
                Color(red: 0.95, green: 0.90, blue: 0.99)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                // Simple toggle
                HStack {
                    Button(showSaved ? "Show API" : "Show Saved") {
                        showSaved.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if showSaved && !savedRecipes.isEmpty {
                        Button("Clear All") {
                            repository?.deleteAllRecipes()
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    }
                }
                .padding()
                
                // Recipe grid
                ScrollView {
                    LazyVGrid(columns:
                                [GridItem(.flexible()),
                                 GridItem(.flexible())
                                ], spacing: 16) {
                        if showSaved {
                            // Show saved recipes
                            ForEach(savedRecipes) { savedRecipe in
                                SavedRecipeCard(savedRecipe: savedRecipe, onUpdate: {
                                    //print("🔄 Updating recipe: \(savedRecipe.title ?? "")")
                                    // Step 3. Update
                                    //savedRecipe.title = "⭐\(savedRecipe.title ?? "Recipe")"
                                    //try? modelContext.save()
                                    // IMPORTANT NOTE: THIS METHOD IS REPOSITORY PATTERN
                                    repository?.starRecipes(savedRecipe)
                                }, onDelete: {
                                    //modelContext.delete(savedRecipe)
                                    //try? modelContext.save()
                                    
                                    // IMPORTANT NOTE: THIS METHOD IS REPOSITORY PATTERN
                                    repository?.deleteRecipes(savedRecipe)
                                })
                                    .onTapGesture {
                                        // Convert to Recipe for detail view
                                        let recipe = Recipe(
                                            id: savedRecipe.id,
                                            title: savedRecipe.title,
                                            image: savedRecipe.image,
                                            imageType: savedRecipe.imageType
                                        )
                                        model.selectedRecipe = recipe
                                    }
                            }
                        } else {
                            // Show API recipes
                            ForEach(model.recipes) { recipe in
                                APIRecipeCard(recipe: recipe) {
                                    //saveRecipe(recipe)
                                    // IMPORTANT NOTE: THIS METHOD IS REPOSITORY PATTERN
                                    repository?.saveRecipe(recipe)
                                }
                                .onTapGesture {
                                    model.selectedRecipe = recipe
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        
        .onAppear {
            if repository == nil {
                repository = RecipeRepository(modelContext: modelContext)
            }
        }
    }
    
    //private func saveRecipe(_ recipe: Recipe) {
    //    let savedRecipe = SavedRecipe(from: recipe)
    //    modelContext.insert(savedRecipe)
    //    try? modelContext.save()
    //}
}


#Preview {
    ListView()
        .environment(RecipeModel())
}
