//
//  Models.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/3/25.
//

import Foundation

// Categories
struct CategoryResponse: Codable {
    let meals: [CategoryItem]
}
struct CategoryItem: Codable, Identifiable {
    var id: String { strCategory }
    let strCategory: String
}

// Areas
struct AreaResponse: Codable {
    let meals: [AreaItem]
}
struct AreaItem: Codable, Identifiable {
    var id: String { strArea }
    let strArea: String
}

// Ingredients
struct IngredientResponse: Codable {
    let meals: [IngredientItem]
}
struct IngredientItem: Codable, Identifiable {
    var id: String { strIngredient }
    let strIngredient: String
}

// Meal list
struct MealListResponse: Codable {
    let meals: [MealItem]
}
struct MealItem: Codable, Identifiable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
}

// Meal detail
struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
struct MealDetail: Codable, Identifiable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
    let strInstructions: String?
}


