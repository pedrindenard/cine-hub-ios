//
//  DiscoveryDetailsViewRouter.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

import SwiftUI

class DiscoveryDetailsViewRouter {
    
    private let rootCoordinator: NavigationCoordinator
    private let discoveryType: DiscoveryType
    
    init(rootCoordinator: NavigationCoordinator, discoveryType: DiscoveryType) {
        self.rootCoordinator = rootCoordinator
        self.discoveryType = discoveryType
    }
    
}

extension DiscoveryDetailsViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = DiscoveryDetailsViewModel(router: self, discoveryType: discoveryType)
        let view = DiscoveryDetailsView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

extension DiscoveryDetailsViewRouter {
    
    static func == (lhs: DiscoveryDetailsViewRouter, rhs: DiscoveryDetailsViewRouter) -> Bool {
        return lhs.discoveryType == rhs.discoveryType
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(discoveryType)
    }
    
}

extension DiscoveryDetailsViewRouter {
    static let mock: DiscoveryDetailsViewRouter = .init(rootCoordinator: NavigationRouter(), discoveryType: .networks)
}
