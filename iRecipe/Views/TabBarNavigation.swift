//
//  TabBarNavigation.swift
//  iRecipe
//
//  Created by Denis Onofras on 19.04.2023.
//

import SwiftUI

struct TabBarNavigation: View {
    enum Tab: Int, CaseIterable, Equatable {
        case categories
        case random
        case saved
        
        var title: String {
            switch self {
            case .categories:
                return "Categories"
            case .random:
                return "Random"
            case .saved:
                return "Saved"
            }
        }
        
        var imageName: String {
            switch self {
            case .categories:
                return "fork.knife.circle.fill"
            case .random:
                return "arrow.triangle.2.circlepath.circle.fill"
            case .saved:
                return "heart.fill"
            }
        }
    }
    
    @State private var selection: Tab = .categories

    var body: some View {

        TabView(selection: $selection) {
            
            ForEach(Tab.allCases, id: \.self) { tab in
                NavigationView {
                    switch tab {
                    case .categories:
                        CategoriesView()
                    case .random:
                        RandomView()
                    case .saved:
                        SavedView()
                    }
                }
                .navigationViewStyle(.stack)
                .tabItem {
                    Label {
                        Text(tab.title)
                    } icon: {
                        Image(systemName: tab.imageName)
                    }
                }
                .tag(tab)
            }
        }
    }
}

struct TabBarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        TabBarNavigation()
    }
}
