//
//  CategoryAdmView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 17/01/25.
//

import SwiftUI

struct CategoryAdmView: View {
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    @StateObject var pager: SearchPagination<Media>
    
    var body: some View {
        if pager.query.isEmpty && pager.items.isEmpty {
            SearchIdleView()
        } else if !pager.query.isEmpty && pager.items.isEmpty && pager.state == .loadingInitial {
            ProgressView()
        } else if !pager.query.isEmpty && pager.items.isEmpty && pager.state == .endReached {
            SearchNoResultsView()
        } else if !pager.query.isEmpty && pager.items.isEmpty && pager.state == .endErr {
            SearchErrorView()
        } else {
            SearchPagerView()
                .contentMargins(.horizontal, 8)
                .onAppear {
                    self.pager.startObservable()
                }
        }
    }
    
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
    private func SearchErrorPagingView() -> some View {
        UnavailableView(
            title: LocalizedString.searchPagerErrorTitle,
            description: LocalizedString.searchPagerErrorDescription
        ) {
            Task {
                await pager.loadMore()
            }
        }
    }
    
    @ViewBuilder
    private func SearchErrorView() -> some View {
        UnavailableView {
            Task {
                await pager.loadInitial(query: pager.query)
            }
        }
    }
}

extension CategoryAdmView {
    
    private func SearchMediaView(_ items: [Media]) -> some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(items) { item in
                MediaPoster(name: item.name, poster: item.poster).onAppear {
                    loadMore(for: item)
                }
            }
        }
    }
}

extension CategoryAdmView {
    private func loadMore(for item: Media) {
        if let index = pager.items.firstIndex(of: item), index >= pager.items.count - 8 {
            Task { await pager.loadMore() }
        }
    }
}

extension CategoryAdmView {
    
    @ViewBuilder
    private func SearchMediaPagerView() -> some View {
        if pager.state == .endErr { SearchErrorPagingView() }
        if pager.state == .loadingMore { ProgressView() }
    }
    
    @ViewBuilder
    private func SearchPagerView() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            SearchMediaView(pager.items)
            SearchMediaPagerView()
        }
    }
}
