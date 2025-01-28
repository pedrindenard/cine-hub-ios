//
//  GenresViewRouter.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import SwiftUI

class GenresViewRouter {
    
    private let rootCoordinator: NavigationCoordinator
    private let genres: Genres
    
    init(rootCoordinator: NavigationCoordinator, genres: Genres) {
        self.rootCoordinator = rootCoordinator
        self.genres = genres
    }
    
}

extension GenresViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = GenresViewModel(router: self, genres: genres)
        let view = GenresView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

extension GenresViewRouter {
    
    static func == (lhs: GenresViewRouter, rhs: GenresViewRouter) -> Bool {
        return lhs.genres == rhs.genres
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(genres)
    }
    
}

extension GenresViewRouter {
    static let mock: GenresViewRouter = .init(rootCoordinator: NavigationRouter(), genres: .movie)
}
