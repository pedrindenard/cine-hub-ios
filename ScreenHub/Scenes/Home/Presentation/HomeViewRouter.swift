//
//  HomePageRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

// MARK: - Class implementation
class HomeViewRouter {
    
    @Injected(\.searchRouterProvider) private var searchRouter: SearchViewRouter
    @Injected(\.navigationProvider) private var navigation: NavigationCoordinator

    private let identifier: UUID
    
    init() {
        self.identifier = UUID()
    }
    
    func routeToSearch() {
        self.navigation.push(searchRouter)
    }
    
    func pop() {
        self.navigation.popLast()
    }
}

// MARK: - ViewFactory implementation
extension HomeViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

// MARK: - Hashable implementation
extension HomeViewRouter {
    
    static func == (lhs: HomeViewRouter, rhs: HomeViewRouter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
}
