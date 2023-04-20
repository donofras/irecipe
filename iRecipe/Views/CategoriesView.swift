//
//  CategoriesView.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import SwiftUI
import Kingfisher

struct CategoriesView: View {
    
    @ObservedObject var viewModel = CategoryViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if !viewModel.searchText.isEmpty && viewModel.recipse.isEmpty {
                        Text("No recipes was found")
                            .font(.title2)
                            .fontWeight(.semibold)
                    } else if !viewModel.recipse.isEmpty {
                        ForEach(viewModel.recipse, id: \.idMeal) { meal in
                            Button {
                                viewModel.getMealById(id: meal.idMeal)
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
                    } else {
                        ForEach(viewModel.categories, id: \.idCategory) { category in
                            NavigationLink(destination: MealsListView(viewModel: .init(mealCategory: category.strCategory))) {
                                HStack {
                                    KFImage(category.previewUrl)
                                        .cancelOnDisappear(true)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    VStack(alignment: .leading) {
                                        Text(category.strCategory)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                    }
                                    
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
        .navigationDestination(isPresented: $viewModel.showMeal, destination: {
            MealView(viewModel: .init(meal: viewModel.selectedMeal))
        })
        .searchable(text: $viewModel.searchText, prompt: "Look for recipes")
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
