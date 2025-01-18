//
//  HomeViewHeader.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject private var pager: SearchPagination = .search()
    @StateObject var viewModel: CategoryViewModel
    
    @State private var isPresented: Bool = false
    @State private var scope: SearchScope = .multi
        
    var body: some View {
        Group {
            if case ViewState.success(let categories) = viewModel.state {
                CategoryNavigationView(categories: categories)
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
    
    private func CategoryNavigationView(categories: [Category]) -> some View {
        NavigationStack {
            if isPresented || !pager.query.isEmpty || !pager.items.isEmpty || pager.state != .idle {
                CategoryAdmView(pager: pager)
            } else {
                CategoryView(categories: categories)
            }
        }
        .searchable(text: $pager.query, isPresented: $isPresented, prompt: LocalizedString.searchPrompt)
        .searchScopes($scope) {
            ForEach(SearchScope.allCases) { scope in
                Text(scope.description)
            }
        }
        .onChange(of: scope) { _, scope in
            pager.updateEndpoint(scope.endpoint)
        }
    }
    
    private func CategoryView(categories: [Category]) -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(alignment: .leading) {
                CategorySectionView(categories: categories)
            }
        }
    }
    
    private func CategorySectionView(categories: [Category]) -> some View {
        ForEach(categories) { category in
            if category.type == .carrousel {
                CategoryCarrouselView(category: category)
            } else {
                CategoryBannerView(category: category)
            }
        }
    }
    
    private func CategoryErrorView(message: String) -> some View {
        UnavailableView {
            viewModel.getCategories()
        }
    }
}

#Preview {
    CategoryView(viewModel: .init(mediaType: .tv))
}
