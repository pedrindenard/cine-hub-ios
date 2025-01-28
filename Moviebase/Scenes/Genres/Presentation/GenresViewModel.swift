//
//  GenresViewModel.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import SwiftUI

class GenresViewModel: ObservableObject {
    
    @Injected(\.genresRepository) var repository: GenresRepository
    
    @Published private(set) var state: ViewState<[Genre]> = .loading
    @Published private(set) var genres: Genres
    
    private let router: GenresViewRouter
    
    init(router: GenresViewRouter, genres: Genres) {
        self.router = router
        self.genres = genres
        self.getGenres()
    }
    
    func getGenres() {
        Task {
            await self.updateState(ViewState.loading)
            
            do {
                let genres = try await repository.getGenres(endpoint: genres.endpoint)
                
                if genres.isEmpty {
                    await self.updateState(.error(message: "TMDB server is offline"))
                } else {
                    await self.updateState(.success(result: genres))
                }
            } catch {
                await self.updateState(.error(message: error.localizedDescription))
            }
        }
    }
    
    @MainActor
    private func updateState(_ newState: ViewState<[Genre]>) {
        withAnimation(.easeIn) {
            self.state = newState
        }
    }
    
}

extension GenresViewModel {
    static let mock: GenresViewModel = .init(router: GenresViewRouter.mock, genres: .movie)
}
