//
//  CategorySectionView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct CategoryCarrouselView: View {
    
    @ScaledMetric private var height: CGFloat = 105 * 1.5
    @ScaledMetric private var width: CGFloat = 105
    
    private let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var body: some View {
        Section {
            SectionContent(category: category)
                .contentMargins(.horizontal, 16)
                .contentMargins(.bottom, 8)
        } header: {
            SectionHeader(category: category)
        }
    }
    
    private func SectionContent(category: Category) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(category.items) { item in
                    SectionItem(item: item)
                }
            }
        }
    }
    
    private func SectionItem(item: Media) -> some View {
        VStack(alignment: .leading) {
            AsyncImageView(aspectRatio: 2/3, path: item.poster)
                .frame(width: width, height: height)
            
            Text(item.name)
                .font(.caption)
                .lineLimit(2, reservesSpace: true)
                .padding(.horizontal, 2)
                .bold()
        }
        .frame(width: width)
    }
    
    private func SectionHeader(category: Category) -> some View {
        Text(category.name)
            .font(.title2)
            .padding(.horizontal)
            .bold()
    }
    
}

#if DEBUG
#Preview {
    let items = [
        Media.preview, Media.preview, Media.preview, Media.preview, Media.preview
    ]
    
    let category = Category(name: "Trending", items: items, type: .carrousel)
    
    ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(alignment: .leading) {
            CategoryCarrouselView(category: category)
            CategoryCarrouselView(category: category)
            CategoryCarrouselView(category: category)
            CategoryCarrouselView(category: category)
        }
    }
}
#endif
