//
//  CategoryMediaView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 21/01/25.
//

import SwiftUI

struct CategoryDetailsView: View {
    
    @StateObject var viewPager: PagerAsync<Media>
    @State var name: String
    
    var body: some View {
        CategoryDetailsContentView()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(name)
    }
    
    @ViewBuilder
    private func CategoryDetailsContentView() -> some View {
        if viewPager.state == .loadingInitial {
            ProgressView()
        } else if viewPager.state == .error && viewPager.items.isEmpty {
            CategoryDetailsFailureView()
        } else {
            LazyScrollView(data: viewPager.items) { item in
                MediaView(name: item.name, poster: item.poster).onAppear {
                    self.loadMore(for: item)
                }
            } pagination: {
                if viewPager.state == .loadingMore { CategoryDetailsLoadingView() }
                if viewPager.state == .error { CategoryDetailsErrorView() }
            }
        }
    }
    
    @ViewBuilder
    private func CategoryDetailsFailureView() -> some View {
        UnavailableView(
            title: LocalizedString.unavailableContentTitle,
            description: LocalizedString.unavailableContentDescription
        ) {
            viewPager.loadInitial()
        }
    }
    
    @ViewBuilder
    private func CategoryDetailsErrorView() -> some View {
        UnavailableDescriptionView(text: LocalizedString.unavailableContentDescription) {
            viewPager.loadMore()
        }
    }
    
    @ViewBuilder
    private func CategoryDetailsLoadingView() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .frame(height: 115)
    }
    
}

extension CategoryDetailsView {
    private func loadMore(for item: Media) {
        guard viewPager.items.last == item else { return }
        viewPager.loadMore()
    }
}
