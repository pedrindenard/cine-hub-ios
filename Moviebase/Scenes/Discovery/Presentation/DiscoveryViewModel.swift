//
//  DiscoveryView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 21/01/25.
//

import SwiftUI

class DiscoveryViewModel: ObservableObject {
    
    @Injected(\.discoveryRepository) private var repository: DiscoveryRepository

    private let router: DiscoveryViewRouter
    
    @Published private(set) var items: [Discovery] = []
    @Published var isSearching: Bool = false

    init(router: DiscoveryViewRouter) {
        self.router = router
        self.items = repository.getCategories()
    }
    
    func navigateTo(_ discoveryType: DiscoveryType) {
        if discoveryType == .genresMovie || discoveryType == .genresTv {
            self.router.routeToDiscoveryGenres(discoveryType: discoveryType)
        } else {
            self.router.routeToDiscoveryDetails(discoveryType: discoveryType)
        }
    }
    
}

extension DiscoveryViewModel {
    static let mock: DiscoveryViewModel = .init(router: DiscoveryViewRouter.mock)
}
