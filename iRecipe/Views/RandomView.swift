//
//  RandomView.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import SwiftUI

struct RandomView: View {
    
    @ObservedObject var viewModel = RandomViewModel()
    
    var body: some View {
        NavigationStack {
            if let meal = viewModel.meal {
                MealView(viewModel: .init(meal: meal))
            } else {
                Text("Something went wrong.\nTry later.")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            viewModel.getRandomMeal()
        }
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
