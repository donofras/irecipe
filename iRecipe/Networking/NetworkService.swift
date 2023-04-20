//
//  NetworkService.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import Foundation
import Combine
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}

protocol NetworkProtocol {
    func fetchCategories() -> AnyPublisher<DataResponse<CategoriesResponse, NetworkError>, Never>
    func fetchRandomMeal() -> AnyPublisher<DataResponse<MealResponse, NetworkError>, Never>
}

class NetworkService {
    static let shared: NetworkProtocol = NetworkService()
    private init() { }
}

extension NetworkService: NetworkProtocol {
    func fetchCategories() -> AnyPublisher<DataResponse<CategoriesResponse, NetworkError>, Never> {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        
        return AF.request(url,
                          method: .get)
        .validate()
        .publishDecodable(type: CategoriesResponse.self)
        .map { response in
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func fetchRandomMeal() -> AnyPublisher<DataResponse<MealResponse, NetworkError>, Never> {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        
        return AF.request(url,
                          method: .get)
        .validate()
        .publishDecodable(type: MealResponse.self)
        .map { response in
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
