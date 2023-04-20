//
//  MealViewModel.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    
    @Published var meal: Meal
    @Published var isSaved: Bool = false

    init(meal: Meal) {
        self.meal = meal
    }
    
    func saveMeal() {
        
    }
}
