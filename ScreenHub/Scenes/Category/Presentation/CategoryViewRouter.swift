//
//  HomePageRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

class CategoryViewRouter {
    
    @Injected(\.navigationProvider) private var navigation: NavigationCoordinator

    private let identifier: UUID
    
    init() {
        self.identifier = UUID()
    }
    
}

extension CategoryViewRouter: Routable {
    
    @MainActor
    func makeView(mediaType: MediaType) -> AnyView {
        let viewModel = CategoryViewModel(mediaType: mediaType)
        let view = CategoryView(viewModel: viewModel)
        return AnyView(view)
    }
    
    func makeView() -> AnyView {
        return AnyView(Group {})
    }
    
}

extension CategoryViewRouter {
    
    static func == (lhs: CategoryViewRouter, rhs: CategoryViewRouter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
}
