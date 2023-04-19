//
//  CategoriesResponse.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import Foundation

// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
