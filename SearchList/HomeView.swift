//
//  ContentView.swift
//  SearchList
//
//  Created by Alberto Garza on 23.11.25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(RecipeModel.self) var model
    @State var selectedTab = 0
    @State var query: String = ""
    @FocusState var queryBoxFocused: Bool
    @State var popularOn = false
    @State var healthyOn = false
    @State var categorySelection = "healthy"
    
    var body: some View {
        
        @Bindable var model = model
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 0.72, green: 0.64, blue: 0.98), // lavender
                Color(red: 0.53, green: 0.78, blue: 0.98), // sky-mint
                Color(red: 0.95, green: 0.90, blue: 0.99)
            ]), startPoint: .topLeading  , endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    TextField("Search..", text: $query)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .fontWeight(.bold)
                        .textFieldStyle(.roundedBorder)
                        .focused($queryBoxFocused)
                    Button {
                        //ToDo
                        queryBoxFocused = false
                        model.fetchRecipes(query: query, diet: getOptionsString(), intolerances: getOptionsString(), excludeCuisine: "", sort: "fiber", number: 10)
                    } label: {
                        Text("Click")
                            .padding(.horizontal)
                            .padding().background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }

                }
                .padding(.horizontal)
                
                if queryBoxFocused {
                    
                    VStack {
                        Toggle("Popular", isOn: $popularOn)
                            .foregroundStyle(Color.white)
                        Toggle("Healthy", isOn: $healthyOn)
                            .foregroundStyle(Color.white)
                        HStack {
                            Spacer()
                            Picker("Category", selection: $categorySelection) {
                                Text("Healthy")
                                    .tag("healthy")
                                Text("Unhealthy")
                                    .tag("unhealthy")
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                }
               
                    ListView()
                        .onTapGesture {
                            queryBoxFocused = false
                        }
            
            }
        }
        .listRowSeparator(.hidden)
        //.onAppear {
        //    model.fetchRecipes(query: query, diet: getOptionsString(), intolerances: getOptionsString(), excludeCuisine: "", sort: "fiber", number: 10)
        //}
        .sheet(item: $model.selectedRecipe) { recipe in
            RecipeDetailView()
        }
    }
    
    func getOptionsString() -> String {
        var options = String()
        if popularOn {
            options.append("gluten")
        }
        if popularOn {
            options.append("dairy")
        }
        if healthyOn {
            options.append("vegan")
        }
        return options
    }
}

#Preview {
    HomeView()
        .environment(RecipeModel())
}
