//
//  SavedViewModel.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import Foundation
import Combine
import RealmSwift

class SavedViewModel: ObservableObject {

    var realmManager: RealmManager
    
    init(realmManager: RealmManager = .shared()) {
        self.realmManager = realmManager
    }
}

