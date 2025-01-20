//
//  CategoryAdmView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 17/01/25.
//

import SwiftUI

struct CategoryAdmView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject var pager: SearchPagination<Media>
    
    private var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            Array(repeating: GridItem(.flexible()), count: 3)
        } else {
            Array(repeating: GridItem(.flexible()), count: 6)
        }
    }
    
    var body: some View {
        if pager.query.isEmpty && pager.items.isEmpty && pager.state == .idle {
            SearchIdleView()
        } else if !pager.query.isEmpty && pager.items.isEmpty && pager.state == .loadingInitial {
            ProgressView()
        } else if !pager.query.isEmpty && pager.items.isEmpty && pager.state == .endReached {
            SearchNoResultsView()
        } else if !pager.query.isEmpty && pager.items.isEmpty && pager.state == .endErr {
            SearchErrorView()
        } else {
            SerachScrollView()
        }
    }
    
    @ViewBuilder
    private func SerachScrollView() -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(pager.items) { item in
                    MediaPoster(name: item.name, poster: item.poster)
                        .onAppear { loadMore(for: item) }
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                }
            }

            if pager.state == .loadingMore { SearchLoadingView() }
            if pager.state == .endErr { SearchErrorPagingView() }
        }
        .contentMargins(.horizontal, 16)
        .onAppear {
            pager.startObservable()
        }
    }
    
    @ViewBuilder
    private func SearchErrorPagingView() -> some View {
        ContentUnavailableView {} description: {
            Text(LocalizedString.searchPagerErrorDescription)
                .padding(.horizontal, 24)
        } actions: {
            UnavailableButtonView {
                Task { await pager.loadMore() }
            }
        }
    }
    
    @ViewBuilder
    private func SearchLoadingView() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .frame(height: 115)
    }
    
}

// MARK: Search states
extension CategoryAdmView {
    
    @ViewBuilder
    private func SearchNoResultsView() -> some View {
        UnavailableView(
            title: LocalizedString.searchNoResultsTitle,
            description: LocalizedString.searchNoResultsDescription,
            system: "exclamationmark.magnifyingglass"
        )
    }
    
    @ViewBuilder
    private func SearchIdleView() -> some View {
        UnavailableView(
            title: LocalizedString.searchIdleTitle,
            description: LocalizedString.searchIdleDescription,
            system: "magnifyingglass"
        )
    }
    
    @ViewBuilder
    private func SearchErrorView() -> some View {
        UnavailableView {
            Task { await pager.loadInitial(query: pager.query) }
        }
    }
    
}

// MARK: Helper functions
extension CategoryAdmView {
    private func loadMore(for item: Media) {
        if let index = pager.items.firstIndex(of: item), index >= pager.items.count - 8 {
            Task { await pager.loadMore() }
        }
    }
}

#Preview {
    
    @Previewable
    @StateObject var viewPager: SearchPagination = SearchPagination.search()
    
    NavigationStack { CategoryAdmView(pager: viewPager) }
        .searchable(text: $viewPager.query, prompt: LocalizedString.searchPrompt)
        .searchScopes($viewPager.scope) {
            ForEach(SearchScope.allCases) { scope in
                Text(scope.description)
            }
        }
        .onChange(of: viewPager.scope) { _, scope in
            viewPager.updateEndpoint(scope.endpoint)
        }
    
}
