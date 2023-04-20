//
//  MealView.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import SwiftUI
import Kingfisher

struct MealView: View {
    
    @ObservedObject var viewModel: MealViewModel
    
    init(viewModel: MealViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                KFImage(viewModel.meal.previewUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
                    .padding()
                
                if let strInstructions = viewModel.meal.strInstructions {
                    Text(strInstructions)
                        .font(.system(size: 14, weight: .regular))
                        .padding()
                }
                
                if let category = viewModel.meal.strCategory {
                    HStack(spacing: 16) {
                        Text("Category:")
                            .font(.system(size: 16, weight: .semibold))

                        Text(category)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                if let area = viewModel.meal.strArea {
                    HStack(spacing: 16) {
                        Text("Area:")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text(area)
                            .font(.system(size: 16, weight: .regular))

                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text("Ingredinets: ")
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    ForEach( viewModel.meal.ingredientsWithMeasures, id: \.self) { ingredinet in
                        Text(ingredinet)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle(viewModel.meal.strMeal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.saveMeal()
                } label: {
                    Image(systemName: viewModel.isSaved ? "arrow.down.heart.fill" : "arrow.down.heart")
                }
            }
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(idMeal: "52772",
                        strMeal: "Teriyaki Chicken Casserole",
                        strCategory: "Chicken",
                        strArea: "Japanese",
                        strInstructions: "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
                        strMealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                        ingredients: ["asdasda", "asdasd", "asdasda"],
                        measures: ["asdas", "23", "22"])
        NavigationStack {
            MealView(viewModel: .init(meal: meal))
        }
    }
}
