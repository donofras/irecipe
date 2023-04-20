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
    @Published var loadingError: String = ""
    @Published var showAlert: Bool = false
    @Published var searchText = ""

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkProtocol
    
    init( dataManager: NetworkProtocol = NetworkService.shared) {
        self.dataManager = dataManager
        getChatList()
    }
    
    func getChatList() {
        dataManager.fetchCategories()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.categories = dataResponse.value!.categories
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        loadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
