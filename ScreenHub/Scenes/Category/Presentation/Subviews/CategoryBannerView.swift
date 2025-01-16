//
//  CategoryBannerView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct CategoryBannerView: View {
    
    private let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var body: some View {
        BannerContent(category: category)
            .contentMargins(.horizontal, 16)
            .contentMargins(.bottom, 8)
    }
    
    private func BannerContent(category: Category) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(category.items) { item in
                    BannerItem(item: item)
                }
                .containerRelativeFrame(.horizontal)
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    private func BannerItem(item: Media) -> some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(aspectRatio: 16/9, quality: "w780", path: item.backdrop)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading) {
                BannerName(name: item.name)
                BannerDescription(voteAverage: item.voteAverage)
            }
            .padding()
        }
    }
    
    private func BannerDescription(voteAverage: Double) -> some View {
        HStack(alignment: .center) {
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .padding(.bottom, 2)
                .shadow()
            
            Text("\(voteAverage)")
                .font(.subheadline)
                .lineLimit(1)
                .bold()
                .shadow()
        }
    }
    
    private func BannerName(name: String) -> some View {
        Text(name)
            .font(.headline)
            .lineLimit(1)
            .bold()
            .shadow()
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
        }
    }
}
#endif
