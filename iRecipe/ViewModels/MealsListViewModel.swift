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
    @Published var isLoading = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkProtocol
    var mealCategory: String
    
    init(dataManager: NetworkProtocol = NetworkManager.shared, mealCategory: String) {
        self.dataManager = dataManager
        self.mealCategory = mealCategory
        
        getMeals()
    }
    
    private func getMeals() {
        isLoading = true
        dataManager.fetchMealsByCategory(category: mealCategory)
            .sink { [weak self] (dataResponse) in
                guard let `self` = self else { return }
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.meals = dataResponse.value!.meals
                    self.isLoading = false
                }
            }.store(in: &cancellableSet)
    }
    
    func getMealById(id: String) {
        isLoading = true
        dataManager.fetchMealById(id: id)
            .sink { [weak self] (dataResponse) in
                guard let `self` = self else { return }
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.selectedMeal = dataResponse.value!.meals?.first
                    self.showMeal = true
                    self.isLoading = false
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        loadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        showAlert = true
        isLoading = false
    }
}
