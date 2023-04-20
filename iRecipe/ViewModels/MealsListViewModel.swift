//
//  MealsListViewModel.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Foundation
import Combine

class MealsListViewModel: ObservableObject {
    
    @Published var meals =  [MealShort]()
    @Published var selectedMeal: Meal?
    @Published var showMeal = false
    @Published var loadingError: String = ""
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkProtocol
    var mealCategory: String
    
    init(dataManager: NetworkProtocol = NetworkService.shared, mealCategory: String) {
        self.dataManager = dataManager
        self.mealCategory = mealCategory
        
        getMeals()
    }
    
    private func getMeals() {
        dataManager.fetchMealsByCategory(category: mealCategory)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.meals = dataResponse.value!.meals
                }
            }.store(in: &cancellableSet)
    }
    
    func getMealById(id: String) {
        dataManager.fetchMealById(id: id)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.selectedMeal = dataResponse.value!.meals?.first
                    self.showMeal = true
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        loadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
