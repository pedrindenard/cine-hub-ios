//
//  HomeViewHeader.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject var viewModel: CategoryViewModel
    
    @ScaledMetric var height: CGFloat = 105 * 1.5
    @ScaledMetric var width: CGFloat = 105
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Group {
                if case ViewState.success(let categories) = viewModel.state {
                    Sections(categories: categories)
                }
                
                if case ViewState.error(_) = viewModel.state {
                    EmptyView(
                        title: "No Data Available",
                        description: "We couldn't find any data to display.\nPlease try again later."
                    ) {
                        Button("Retry") {
                            viewModel.startLoading()
                            viewModel.startFetching()
                        }.buttonStyle(.bordered)
                    }
                }
                
                if case ViewState.loading = viewModel.state {
                    ProgressView()
                }
            }
            .animation(.easeInOut, value: viewModel.state)
        }
    }
    
    private func Sections(categories: [Category]) -> some View {
        LazyVStack(alignment: .leading) {
            ForEach(categories, id: \.name) { category in
                Section {
                    SectionContent(category: category)
                } header: {
                    SectionHeader(category: category)
                }
            }
        }
    }
    
    private func SectionFooter(item: CategoryItem) -> some View {
        VStack(alignment: .leading) {
            AsyncImageView(path: item.imagePath)
                .frame(width: width, height: height)
            
            Text(item.name)
                .font(.caption)
                .lineLimit(2, reservesSpace: true)
                .padding(.horizontal, 2)
                .bold()
        }
        .frame(width: width)
    }
    
    private func SectionContent(category: Category) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(category.items, id: \.name) { item in
                    SectionFooter(item: item)
                }
            }
        }
        .contentMargins(.horizontal, 16)
        .contentMargins(.bottom, 8)
    }
    
    private func SectionHeader(category: Category) -> some View {
        Text(category.name)
            .font(.title2)
            .padding(.horizontal)
            .bold()
    }
    
}

#Preview {
    CategoryView(viewModel: .init())
}
