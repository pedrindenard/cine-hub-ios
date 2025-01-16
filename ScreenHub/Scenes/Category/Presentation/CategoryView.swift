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
        Group {
            if case ViewState.success(let categories) = viewModel.state {
                SectionView(categories: categories)
                    .contentMargins(.bottom, 16)
                    .contentMargins(.top, 16)
            }
            
            if case ViewState.error(let message) = viewModel.state {
                FailureView(message: message)
            }
            
            if case ViewState.loading = viewModel.state {
                LoadingView()
            }
        }
        .transition(.opacity)
    }
    
    private func SectionView(categories: [Category]) -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(alignment: .leading) {
                SectionStackView(categories: categories)
            }
        }
    }
    
    private func SectionStackView(categories: [Category]) -> some View {
        ForEach(categories) { category in
            if category.type == .carrousel {
                CategoryCarrouselView(category: category)
            } else {
                CategoryBannerView(category: category)
            }
        }
    }
    
    private func FailureView(message: String) -> some View {
        EmptyView(
            title: "No Data Available",
            description: "We couldn't find any data to display.\n\(message)."
        ) {
            ButtonView(title: "Retry")
                .buttonStyle(.bordered)
        }
    }
    
    private func ButtonView(title: String) -> some View {
        Button(title) {
            viewModel.startLoading()
            viewModel.startFetching()
        }
    }
    
}

#Preview {
    CategoryView(viewModel: .init(mediaType: .tv))
}
