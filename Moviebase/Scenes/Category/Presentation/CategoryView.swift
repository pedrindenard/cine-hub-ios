//
//  HomeViewHeader.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @StateObject private var viewPager: SearchPagination = .search()
    @StateObject var viewModel: CategoryViewModel
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Group {
            if case ViewState.success(let categories) = viewModel.state {
                CategoryNavigationView(categories: categories)
                    .searchable(text: $viewPager.query, isPresented: $isPresented, prompt: LocalizedString.searchPrompt)
                    .searchScopes($viewPager.scope) {
                        ForEach(SearchScope.allCases) { scope in
                            Text(scope.description)
                        }
                    }
                    .onChange(of: viewPager.scope) { _, scope in
                        viewPager.updateEndpoint(scope.endpoint)
                    }
            }
            
            if case ViewState.error(let message) = viewModel.state {
                CategoryErrorView(message: message)
            }
            
            if case ViewState.loading = viewModel.state {
                LoadingView()
            }
        }
        .transition(.opacity)
    }
    
    @ViewBuilder
    private func CategoryNavigationView(categories: [Category]) -> some View {
        if isPresented {
            CategoryAdmView(pager: viewPager)
                .toolbar(viewPager.query.isEmpty ? .visible : .hidden, for: .tabBar)
                .toolbarAnimation(value: viewPager.query.isEmpty)
        } else {
            CategoryView(categories: categories)
                .toolbarBackground(horizontalSizeClass == .compact ? .hidden : .automatic, for: .navigationBar)
        }
    }
    
    @ViewBuilder
    private func CategoryView(categories: [Category]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                CategorySectionView(categories: categories)
            }
        }
    }
    
    @ViewBuilder
    private func CategorySectionView(categories: [Category]) -> some View {
        ForEach(categories) { category in
            if category.type == .carrousel {
                CategoryCarrouselView(category: category)
            } else {
                CategoryBannerView(category: category)
            }
        }
    }
    
    @ViewBuilder
    private func CategoryErrorView(message: String) -> some View {
        UnavailableView {
            viewModel.getCategories()
        }
    }
}

#Preview {
    CategoryView(viewModel: .init(mediaType: .tv))
}
