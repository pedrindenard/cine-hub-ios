//
//  HomeViewHeader.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject private var pagination: SearchPagination = SearchPagination.search(endpoint: .searchMulti)
    @StateObject var viewModel: CategoryViewModel
    
    @ScaledMetric private var height: CGFloat = 105 * 1.5
    @ScaledMetric private var width: CGFloat = 105
    
    @State private var isPresented: Bool = false
    
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
        NavigationStack {
            if isPresented || !pagination.query.isEmpty || !pagination.items.isEmpty || pagination.state != .idle {
                if pagination.query.isEmpty && pagination.items.isEmpty {
                    UnavailableView(
                        title: "Pesquisa CineHub",
                        description: "Por favor, insira um título para a sua pesquisa..."
                    ) {
                        
                    }
                } else if !pagination.query.isEmpty && pagination.items.isEmpty && pagination.state == .loadingInitial {
                    ProgressView()
                } else if !pagination.query.isEmpty && pagination.items.isEmpty && pagination.state == .endReached {
                    UnavailableView(
                        title: "Nenhum resultado encontrado",
                        description: "Verifique se o título está correto e tente novamente..."
                    ) {
                        
                    }
                } else if !pagination.query.isEmpty && pagination.items.isEmpty && pagination.state == .endErr {
                    UnavailableView(
                        title: LocalizedString.unavailableContentTitle,
                        description: LocalizedString.unavailableContentDescription
                    ) {
                        UnavailableButtonView(LocalizedString.unavailableContentRetry) {
                            Task {
                                await pagination.loadInitial(query: pagination.query)
                            }
                        }
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: true) {
                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(pagination.items) { item in
                                MediaPoster(name: item.name, poster: item.poster).onAppear {
                                    if pagination.items[pagination.items.count/4].id == item.id || pagination.items.last?.id == item.id {
                                        Task {
                                            await pagination.loadMore()
                                        }
                                    }
                                }
                            }
                            
                            if pagination.state == .loadingMore {
                                ProgressView("Loading...")
                                    .gridCellAnchor(.center)
                                    .gridCellColumns(3)
                            } else if pagination.state == .endErr {
                                ContentUnavailableView {
                                    Text("Failed to load more")
                                } description: {
                                    Text("Something went wrong while loading more content")
                                } actions: {
                                    Button("Retry") {
                                        Task {
                                            await pagination.loadMore()
                                        }
                                    }.buttonStyle(.borderless)
                                }
                                .gridCellAnchor(.center)
                                .gridCellColumns(3)
                            }
                        }
                    }
                    .contentMargins(.horizontal, 8)
                    .onAppear {
                        self.pagination.startObservable()
                    }
                }
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .leading) {
                        SectionStackView(categories: categories)
                    }
                }
            }
        }
        .searchable(text: $pagination.query, isPresented: $isPresented, placement: .automatic, prompt: "The Walking Dead...")
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
        UnavailableView(
            title: LocalizedString.unavailableContentTitle,
            description: LocalizedString.unavailableContentDescription
        ) {
            UnavailableButtonView(LocalizedString.unavailableContentRetry) {
                viewModel.getCategories()
            }
        }
    }
    
}

#Preview {
    CategoryView(viewModel: .init(mediaType: .tv))
}
