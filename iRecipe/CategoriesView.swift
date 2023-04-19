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
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.categories, id: \.idCategory) { category in
                        HStack {
                            KFImage(category.previewUrl)
                                .cancelOnDisappear(true)
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(category.strCategory)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                            
                        }.padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Look for recipes")
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
