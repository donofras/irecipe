//
//  MealViewModel.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Foundation
import Combine
import RealmSwift

class MealViewModel: ObservableObject {
    
    @Published var meal: Meal?
    @Published var isSaved: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var realmManager: RealmManager

    init(meal: Meal?, realmManager: RealmManager = .shared()) {
        self.meal = meal
        self.realmManager = realmManager
        
        realmManager.mealsObect.objectWillChange
            .sink { _ in
                self.isSaved = realmManager.mealsObect.contains(where: { $0.idMeal == meal?.idMeal })
            }
            .store(in: &cancellableSet)
    }
    
    func saveMeal() {
        guard let meal = meal else { return }
        if isSaved {
            RealmManager.shared().deleteMeal(meal: meal)
        } else {
            RealmManager.shared().saveMeal(meal: meal)
        }
    }
}

