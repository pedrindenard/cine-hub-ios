//
//  HomeViewHeader.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject private var viewPager: PagerQuery = .fetcher()
    @StateObject var viewModel: CategoryViewModel
    
    var body: some View {
        CategoryView().transition(.opacity)
    }
    
    @ViewBuilder
    private func CategoryView() -> some View {
        if case ViewState.success(let categories) = viewModel.state {
            CategoryNavigationView(categories: categories)
                .searchable(text: $viewPager.query, isPresented: $viewModel.isSearching, prompt: LocalizedString.searchPrompt)
                .searchScopes($viewPager.scope) {
                    ForEach(SearchScope.allCases) { scope in
                        Text(scope.description)
                    }
                }
                .onChange(of: viewPager.scope) { _, scope in
                    viewPager.updateEndpoint(scope.endpoint)
                }
        }
        
        if case ViewState.error = viewModel.state {
            CategoryErrorView()
        }
        
        if case ViewState.loading = viewModel.state {
            LoadingView()
        }
    }
    
    @ViewBuilder
    private func CategoryNavigationView(categories: [Category]) -> some View {
        if viewModel.isSearching {
            SearchView(viewPager: viewPager)
                .toolbar(viewPager.query.isEmpty ? .visible : .hidden, for: .tabBar)
                .toolbarAnimation(value: viewPager.query.isEmpty)
        } else {
            CategoryListView(categories: categories)
                .contentMargins(.vertical, 16)
        }
    }
    
    @ViewBuilder
    private func CategoryListView(categories: [Category]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                CategorySectionView(categories: categories)
            }
        }
    }
    
    @ViewBuilder
    private func CategorySectionView(categories: [Category]) -> some View {
        ForEach(categories) { category in
            CategoryCarrouselView(category: category) {
                viewModel.navigateToCategoryDetails(category)
            }
        }
    }
    
    @ViewBuilder
    private func CategoryErrorView() -> some View {
        UnavailableView {
            viewModel.getCategories()
        }
    }
}

#Preview {
    CategoryView(viewModel: .mock)
}
