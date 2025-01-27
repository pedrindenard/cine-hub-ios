//
//  CategoryAdmView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 17/01/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewPager: PagerQuery<Media>
    
    var body: some View {
        if viewPager.query.isEmpty {
            SearchIdleView()
        } else if viewPager.state == .loadingInitial {
            ProgressView()
        } else if viewPager.state == .endReached && viewPager.items.isEmpty {
            SearchNoResultsView()
        } else if viewPager.state == .error && viewPager.items.isEmpty {
            SearchFailureView()
        } else {
            SerachScrollView()
        }
    }
    
    @ViewBuilder
    private func SerachScrollView() -> some View {
        LazyScrollView(data: viewPager.items) { item in
            MediaView(name: item.name, poster: item.poster).onAppear {
                self.loadMore(for: item)
            }
        } pagination: {
            if viewPager.state == .loadingMore { SearchLoadingView() }
            if viewPager.state == .error { SearchErrorView() }
        }
        .onAppear {
            viewPager.onApper()
        }
    }
    
    @ViewBuilder
    private func SearchErrorView() -> some View {
        UnavailableDescriptionView(text: LocalizedString.searchPagerErrorDescription) {
            viewPager.loadMore()
        }
    }
    
    @ViewBuilder
    private func SearchLoadingView() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .frame(height: 115)
    }
    
}

extension SearchView {
    
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
    private func SearchFailureView() -> some View {
        UnavailableView(
            title: LocalizedString.unavailableContentTitle,
            description: LocalizedString.unavailableContentDescription
        ) {
            viewPager.retry()
        }
    }
    
}

extension SearchView {
    private func loadMore(for item: Media) {
        guard viewPager.items.last == item else { return }
        viewPager.loadMore()
    }
}
