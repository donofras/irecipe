//
//  MealResponse.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import Foundation

// MARK: - MealResponse
struct MealResponse: Decodable {
    let meals: [Meal]?
}

// MARK: - Meal
class Meal: Decodable {
    internal init(idMeal: String, strMeal: String, strDrinkAlternate: String? = nil, strCategory: String? = nil, strArea: String? = nil, strInstructions: String? = nil, strMealThumb: String? = nil, strTags: String? = nil, strYoutube: String? = nil, strSource: String? = nil, strImageSource: String? = nil, strCreativeCommonsConfirmed: String? = nil, dateModified: String? = nil, ingredients: [String?] = [], measures: [String?] = []) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strDrinkAlternate = strDrinkAlternate
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.strSource = strSource
        self.strImageSource = strImageSource
        self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
        self.dateModified = dateModified
        self.ingredients = ingredients
        self.measures = measures
    }
    
    let idMeal, strMeal: String
    let strDrinkAlternate: String?
    let strCategory, strArea, strInstructions: String?
    let strMealThumb, strTags, strYoutube: String?
    let strSource, strImageSource, strCreativeCommonsConfirmed, dateModified: String?
    var ingredients: [String?] = []
    var measures: [String?] = []
    
    var previewUrl: URL? {
        return URL(string: strMealThumb ?? "")
    }
    
    var ingredientsWithMeasures: [String] {
        let ingredients = ingredients.compactMap { $0 }.filter({ $0 != ""})
        let measures = measures.compactMap { $0 }.filter({ $0 != ""})
        return zip(ingredients, measures).map { $0 + ": " + $1 }
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal
        case strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
        case strSource, strImageSource, strCreativeCommonsConfirmed, dateModified
        
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient1))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient2))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient3))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient4))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient5))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient6))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient7))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient8))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient9))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient10))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient11))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient12))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient13))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient14))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient15))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient16))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient17))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient18))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient19))
        ingredients.append(try container.decodeIfPresent(String.self, forKey: .strIngredient20))
        
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure1))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure2))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure3))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure4))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure5))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure6))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure7))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure8))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure9))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure10))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure11))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure12))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure13))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure14))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure15))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure16))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure17))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure18))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure19))
        measures.append(try container.decodeIfPresent(String.self, forKey: .strMeasure20))
    }
}
