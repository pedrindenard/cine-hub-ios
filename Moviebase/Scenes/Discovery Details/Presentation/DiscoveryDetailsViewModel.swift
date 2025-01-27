//
//  DiscoveryDetailsViewModel.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

import SwiftUI

class DiscoveryDetailsViewModel: ObservableObject {
    
    @Injected(\.discoveryDetailsRepository) private var repository: DiscoveryDetailsRepository
    
    @Published private(set) var discoveryType: DiscoveryType
    @Published private(set) var items: [DiscoveryItem] = []

    private let router: DiscoveryDetailsViewRouter

    init(router: DiscoveryDetailsViewRouter, discoveryType: DiscoveryType) {
        self.router = router
        self.discoveryType = discoveryType
        self.items = repository.getChannels(from: discoveryType)
    }
    
}

extension DiscoveryDetailsViewModel {
    static let mock: DiscoveryDetailsViewModel = .init(router: DiscoveryDetailsViewRouter.mock, discoveryType: .networks)
}
