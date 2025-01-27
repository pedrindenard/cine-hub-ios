//
//  CategorySectionView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct CategoryCarrouselView: View {
    
    @ScaledMetric private var height: CGFloat = 120 * 1.5
    @ScaledMetric private var width: CGFloat = 120
    
    let category: Category
    let action: () -> Void
    
    var body: some View {
        Section {
            SectionContent(category: category)
                .contentMargins(.horizontal, 20)
                .contentMargins(.bottom, 8)
        } header: {
            SectionHeader(category: category)
        }
    }
    
    @ViewBuilder
    private func SectionContent(category: Category) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(category.items) { item in
                    MediaView(width: width, height: height, name: item.name, poster: item.poster)
                }
            }
        }
    }
    
    @ViewBuilder
    private func SectionHeader(category: Category) -> some View {
        HStack {
            Text(category.name)
                .font(.title2)
                .padding(.horizontal, 20)
                .bold()
            
            Spacer()
            
            Button(LocalizedString.buttonMore, action: action)
                .padding(.horizontal, 20)
                .bold()
        }
    }
}

#if DEBUG
#Preview {
    let items = [
        Media.preview, Media.preview, Media.preview, Media.preview, Media.preview
    ]
    
    let category = Category(name: LocalizedString.categoryTrending, items: items, endpoint: .popularMovies)
    
    ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(alignment: .leading) {
            CategoryCarrouselView(category: category) {}
            CategoryCarrouselView(category: category) {}
            CategoryCarrouselView(category: category) {}
            CategoryCarrouselView(category: category) {}
        }
    }
}
#endif
