//
//  MealListResponse.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Foundation

// MARK: - MealListResponse
struct MealListResponse: Decodable {
    let meals: [MealShort]
}

// MARK: - Meal
struct MealShort: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    var previewUrl: URL? {
        return URL(string: strMealThumb)
    }
}
