//
//  CategoryBannerView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct CategoryBannerView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let category: Category
    
    var body: some View {
        if horizontalSizeClass == .compact {
            BannerContent(category: category)
                .contentMargins(.horizontal, 20)
                .contentMargins(.bottom, 8)
        } else {
            CategoryCarrouselView(category: category)
        }
    }
    
    private func BannerContent(category: Category) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(category.items) { item in
                    MediaBanner(name: item.name, backdrop: item.backdrop, rating: item.voteAverage)
                }
                .containerRelativeFrame(.horizontal)
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#if DEBUG
#Preview {
    let items = [
        Media.preview, Media.preview, Media.preview, Media.preview, Media.preview
    ]
    
    let category = Category(name: "Popular", items: items, type: .banner)
    
    ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(alignment: .leading) {
            CategoryBannerView(category: category)
            CategoryBannerView(category: category)
            CategoryBannerView(category: category)
            CategoryBannerView(category: category)
        }
    }
}
#endif
