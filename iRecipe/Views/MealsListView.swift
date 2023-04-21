//
//  MealsListView.swift
//  iRecipe
//
//  Created by Denis Onofras on 20.04.2023.
//

import SwiftUI
import Kingfisher

struct MealsListView: View {
    
    @ObservedObject var viewModel: MealsListViewModel
    
    init(viewModel: MealsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.meals, id: \.idMeal) { meal in
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
                }
            }
            .overlay() {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
        }
        .navigationTitle("Category: \(viewModel.mealCategory)")
        .navigationDestination(isPresented: $viewModel.showMeal, destination: {
            MealView(viewModel: .init(meal: viewModel.selectedMeal))
        })
    }
}

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MealsListView(viewModel: .init(mealCategory: "Seafood"))
        }
    }
}
