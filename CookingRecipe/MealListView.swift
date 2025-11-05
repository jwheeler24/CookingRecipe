//
//  MealListView.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

struct MealListView: View {
    let filterType: String
    let filterValue: String
    @State private var meals: [MealItem] = []
    
    var body: some View {
        List(meals) { meal in
            NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                HStack {
                    AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                        img.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(meal.strMeal)
                        .font(.headline)
                }
            }
        }
        .navigationTitle(filterValue)
        .onAppear {
            let cacheKey = "meals-\(filterType)-\(filterValue)"
            
            let encodedValue = filterValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? filterValue
            let url = "https://www.themealdb.com/api/json/v1/1/filter.php?\(filterType)=\(encodedValue)"
            
            MealDBAPI.fetch(
                url: url,
                decodeType: MealListResponse.self,
                cacheKey: cacheKey,
                maxAge: 86400
            ) { result in
                meals = result?.meals ?? []
            }
        }
    }
}

