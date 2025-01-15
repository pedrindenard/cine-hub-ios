//
//  HomePageRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

// MARK: - Class implementation
class CategoryViewRouter {
    
    @Injected(\.searchRouterProvider) private var searchRouter: SearchViewRouter
    @Injected(\.navigationProvider) private var navigation: NavigationCoordinator

    private let identifier: UUID
    
    init() {
        self.identifier = UUID()
    }
    
    func routeToSearch() {
        self.navigation.push(searchRouter)
    }
    
}

// MARK: - ViewFactory implementation
extension CategoryViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = CategoryViewModel()
        let view = CategoryView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

// MARK: - Hashable implementation
extension CategoryViewRouter {
    
    static func == (lhs: CategoryViewRouter, rhs: CategoryViewRouter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
}
