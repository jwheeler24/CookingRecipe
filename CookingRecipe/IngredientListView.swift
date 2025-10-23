//
//  IngredientListView.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

struct IngredientListView: View {
    @State private var ingredients: [IngredientItem] = []
    
    var body: some View {
        List(ingredients) { ing in
            NavigationLink(destination: MealListView(filterType: "i", filterValue: ing.strIngredient)) {
                Text(ing.strIngredient)
                .foregroundColor(.primary)
            }
        }
        .navigationTitle("Ingredients")
        .listRowBackground(Color.clear)
        .scrollContentBackground(.hidden)
        .background(Color(.systemBackground))

        .onAppear {
            MealDBAPI.fetch(
                url: "https://www.themealdb.com/api/json/v1/1/list.php?i=list",
                decodeType: IngredientResponse.self
            ) { result in
                ingredients = result?.meals ?? []
            }
        }
    }
}


