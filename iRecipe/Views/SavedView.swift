//
//  SavedView.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import SwiftUI
import Kingfisher
import RealmSwift

struct SavedView: View {
    
    @ObservedResults(MealObject.self) var realmMeals
    @ObservedObject var viewModel = SavedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(realmMeals, id: \.idMeal) { meal in
                        NavigationLink {
                            MealView(viewModel: .init(meal: viewModel.realmManager.getMealFromObject(from: meal)))
                        } label: {
                            HStack {
                                KFImage(meal.previewUrl)
                                    .cancelOnDisappear(true)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(meal.strMeal)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal)
                                
                                Spacer()
                                
                            }.padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SavedView()
        }
    }
}
