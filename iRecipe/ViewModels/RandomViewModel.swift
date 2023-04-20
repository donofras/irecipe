//
//  RandomViewModel.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import Foundation
import Combine

class RandomViewModel: ObservableObject {
    
    @Published var meal: Meal?
    @Published var loadingError: String = ""
    @Published var showAlert: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkProtocol
    
    init( dataManager: NetworkProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getRandomMeal() {
        dataManager.fetchRandomMeal()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.meal = dataResponse.value!.meals?.first
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        loadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
