//
//  HomePageRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//
import SwiftUI

// MARK: - Class implementation
class SearchViewRouter {
    
    @Injected(\.navigationProvider) private var navigation: NavigationCoordinator
    private let identifier: UUID
    
    init() {
        self.identifier = UUID()
    }
    
    func pop() {
        self.navigation.popLast()
    }

}

// MARK: - ViewFactory implementation
extension SearchViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = SearchViewModel()
        let view = SearchView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

// MARK: - Hashable implementation
extension SearchViewRouter {
    
    static func == (lhs: SearchViewRouter, rhs: SearchViewRouter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
}
