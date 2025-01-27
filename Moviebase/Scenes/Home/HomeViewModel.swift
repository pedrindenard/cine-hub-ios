//
//  HomeViewModel.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    
    private let router: HomeViewRouter = .init()

    func makeCategoryMovieRouter(_ rootCoordinator: NavigationCoordinator) -> any Routable {
        let router = CategoryViewRouter(rootCoordinator: rootCoordinator, mediaType: .movie)
        return router
    }
    
    func makeCategoryTvRouter(_ rootCoordinator: NavigationCoordinator) -> any Routable {
        let router = CategoryViewRouter(rootCoordinator: rootCoordinator, mediaType: .tv)
        return router
    }
    
    func makeDiscoveryRouter(_ rootCoordinator: NavigationCoordinator) -> any Routable {
        let router = DiscoveryViewRouter(rootCoordinator: rootCoordinator)
        return router
    }
    
}

extension HomeViewModel {
    static let mock: HomeViewModel = .init()
}
