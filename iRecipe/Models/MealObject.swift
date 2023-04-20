//
//  MealObject.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Foundation
import RealmSwift

class MealObject: Object, Identifiable {
    @Persisted(primaryKey: true) var idMeal: String
    @Persisted var strMeal: String
    @Persisted var strInstructions: String?
    @Persisted var strCategory: String?
    @Persisted var strArea: String?
    @Persisted var previewUrlString: String?
    @Persisted var ingredients: List<String>
    @Persisted var measures: List<String>
    @Persisted var ingredientsWithMeasures: List<String>
    
    convenience init(idMeal: String,
                     strMeal: String,
                     strInstructions: String?,
                     strCategory: String?,
                     strArea: String?,
                     previewUrlString: String?,
                     ingredients: [String],
                     measures: [String],
                     ingredientsWithMeasures: [String]) {
        self.init()
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strInstructions = strInstructions
        self.strCategory = strCategory
        self.strArea = strArea
        self.previewUrlString = previewUrlString
        self.ingredients.append(objectsIn: ingredients)
        self.measures.append(objectsIn: measures)
        self.ingredientsWithMeasures.append(objectsIn: ingredientsWithMeasures)
    }
    
    var previewUrl: URL? {
        return URL(string: previewUrlString ?? "")
    }
}
