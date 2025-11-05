//
//  CategoryListView.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

struct CategoryListView: View {
    @State private var categories: [CategoryItem] = []
    
    var body: some View {
        List(categories) { cat in
            NavigationLink(destination: MealListView(filterType: "c", filterValue: cat.strCategory)) {
                Text(cat.strCategory)
                    .foregroundColor(.primary)
            }
        }
        .navigationTitle("Categories")
        .listRowBackground(Color.clear)
        .scrollContentBackground(.hidden)
        .background(Color(.systemBackground))
        .onAppear {
            MealDBAPI.fetch(
                url: "https://www.themealdb.com/api/json/v1/1/list.php?c=list",
                decodeType: CategoryResponse.self,
                cacheKey: "categories",
                maxAge: 86400                  
            ) { result in
                categories = result?.meals ?? []
            }
        }
    }
}


