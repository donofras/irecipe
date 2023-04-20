//
//  RealmManager.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Combine
import RealmSwift

final class RealmManager {
    
    private static let sharedInstance = RealmManager()
    
    @ObservedResults(MealObject.self) var mealsObect
    
    var isEmpty: Bool {
        if let realm = realm {
            return realm.objects(MealObject.self).isEmpty
        }
        
        return true
    }

    private func getMealObjects() -> Results<MealObject>? {
        return realm?.objects(MealObject.self)
    }

    private var realm: Realm?
    
    class func shared() -> RealmManager {
        return sharedInstance
    }

    init() {
        realm = try? Realm()
    }
    
    func saveMeal(meal: Meal) {
        let realmInstance = realm
        let mealDataBaseModels = createMealBaseModels(from: meal)
        
        try? realmInstance?.write {
            realmInstance?.add(mealDataBaseModels)
        }
    }
    
    func deleteMeal(meal: Meal) {
        guard let mealObject = realm?.object(ofType: MealObject.self, forPrimaryKey: meal.idMeal) else { return }
        
        try? realm?.write {
            realm?.delete(mealObject)
        }
    }
    
    func getMealFromObject(from object: MealObject) -> Meal {
        let meal = Meal(idMeal: object.idMeal,
                        strMeal: object.strMeal,
                        strCategory: object.strCategory,
                        strArea: object.strArea,
                        strInstructions: object.strInstructions,
                        strMealThumb: object.previewUrlString,
                        ingredients: object.ingredients.compactMap({ $0 }),
                        measures: object.measures.compactMap({ $0 }))
        
        return meal
    }

    private func createMealBaseModels(from meal: Meal) -> MealObject {
        let mealObject = MealObject(idMeal: meal.idMeal,
                                    strMeal: meal.strMeal,
                                    strInstructions: meal.strInstructions,
                                    strCategory: meal.strCategory,
                                    strArea: meal.strArea,
                                    previewUrlString: meal.strMealThumb,
                                    ingredients: meal.ingredients.compactMap({ $0 }),
                                    measures: meal.measures.compactMap({ $0 }),
                                    ingredientsWithMeasures: meal.ingredientsWithMeasures)
        
        return mealObject
    }
}
