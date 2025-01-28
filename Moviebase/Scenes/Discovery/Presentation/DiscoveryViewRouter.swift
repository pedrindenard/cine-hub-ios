//
//  CategoryViewRouter.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 22/01/25.
//

import SwiftUI

class DiscoveryViewRouter {
    
    private let rootCoordinator: NavigationCoordinator
    private let identifier: UUID
    
    init(rootCoordinator: NavigationCoordinator) {
        self.rootCoordinator = rootCoordinator
        self.identifier = UUID()
    }
    
}

extension DiscoveryViewRouter: Routable {
    
    func routeToDiscoveryDetails(discoveryType: DiscoveryType) {
        let router = DiscoveryDetailsViewRouter(rootCoordinator: self.rootCoordinator, discoveryType: discoveryType)
        rootCoordinator.push(router)
    }
    
    func routeToDiscoveryGenres(discoveryType: DiscoveryType) {
        let router = GenresViewRouter(rootCoordinator: self.rootCoordinator, genres: discoveryType.genres)
        rootCoordinator.push(router)
    }
    
    func makeView() -> AnyView {
        let viewModel = DiscoveryViewModel(router: self)
        let view = DiscoveryView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

extension DiscoveryViewRouter {
    
    static func == (lhs: DiscoveryViewRouter, rhs: DiscoveryViewRouter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
}

extension DiscoveryViewRouter {
    static let mock: DiscoveryViewRouter = .init(rootCoordinator: NavigationRouter())
}
