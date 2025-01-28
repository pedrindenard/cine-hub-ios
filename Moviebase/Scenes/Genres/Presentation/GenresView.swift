//
//  GenresView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import SwiftUI

struct GenresView: View {
    
    @StateObject var viewModel: GenresViewModel
    
    var body: some View {
        Group {
            if case .success(let genres) = viewModel.state {
                GenresListView(genres: genres)
            } else if case .error = viewModel.state {
                GenresErrorView()
            } else if case .loading = viewModel.state {
                LoadingView()
            }
        }
        .navigationTitle(viewModel.genres.description)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func GenresListView(genres: [Genre]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(genres) { genre in
                    GenreVView(name: genre.name) {}
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 4)
            }
            .padding(.horizontal, 16)
        }
        .contentMargins(.horizontal, 0)
        .contentMargins(.vertical, 16)
    }
    
    @ViewBuilder
    private func GenresErrorView() -> some View {
        UnavailableView {
            viewModel.getGenres()
        }
    }
    
}

#Preview {
    GenresView(viewModel: .mock)
}
