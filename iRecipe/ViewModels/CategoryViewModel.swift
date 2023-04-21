//
//  CategoryViewModel.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    
    @Published var categories =  [Category]()
    @Published var recipse = [Meal]()
    @Published var loadingError: String = ""
    @Published var showAlert: Bool = false
    @Published var searchText = ""
    @Published var selectedMeal: Meal?
    @Published var showMeal = false
    @Published var isLoading = false

    private var cancellableSet: Set<AnyCancellable> = []
    private var dataManager: NetworkProtocol
    
    init( dataManager: NetworkProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
        getAllCategories()
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] searchText in
            guard let `self` = self else { return }
            
            self.searchByName(name: searchText)
            
        }).store(in: &cancellableSet)
    }
    
    func getAllCategories() {
        isLoading = true
        dataManager.fetchCategories()
            .sink { [weak self] (dataResponse) in
                guard let `self` = self else { return }
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.categories = dataResponse.value?.categories ?? []
                    self.isLoading = false
                }
            }.store(in: &cancellableSet)
    }
    
    func getMealById(id: String) {
        isLoading = true
        dataManager.fetchMealById(id: id)
            .sink { [weak self]  (dataResponse) in
                guard let `self` = self else { return }
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.selectedMeal = dataResponse.value?.meals?.first
                    self.showMeal = true
                    self.isLoading = false
                }
            }.store(in: &cancellableSet)
    }
    
    
    func searchByName(name: String) {
        guard name.count > 0 else {
            recipse = []
            return
        }
        isLoading = true
        dataManager.fetchMealByName(name: name)
            .sink { [weak self] (dataResponse) in
                guard let `self` = self else { return }
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.recipse = dataResponse.value?.meals ?? []
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
