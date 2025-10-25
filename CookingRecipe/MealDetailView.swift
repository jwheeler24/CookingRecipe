//
//  MealDetailView.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @State private var meal: MealDetail?
    @StateObject private var handVM = HandGestureViewModel()
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let meal = meal {
                        AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { img in
                            img.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .cornerRadius(12)
                        .id("top")
                        
                        Text(meal.strMeal)
                            .font(.largeTitle)
                            .bold()
                        
                        if let instructions = meal.strInstructions {
                            Text(instructions)
                                .font(.body)
                                .padding(.top, 8)
                                .id("instructions")
                        }
                    } else {
                        ProgressView("Loading...")
                    }
                }
                .padding()
            }
            .navigationTitle("Details")
            .onAppear {
                let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
                MealDBAPI.fetch(url: url, decodeType: MealDetailResponse.self) { result in
                    meal = result?.meals.first
                }
            }
            .onReceive(handVM.$scrollDirection) { dir in
                if dir == "up" {
                    withAnimation { proxy.scrollTo("top", anchor: .top) }
                } else if dir == "down" {
                    withAnimation { proxy.scrollTo("instructions", anchor: .bottom) }
                }
            }
        }
    }
}

