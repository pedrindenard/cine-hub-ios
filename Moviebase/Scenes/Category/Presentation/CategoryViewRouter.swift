//
//  HomePageRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

class CategoryViewRouter {
    
    private let rootCoordinator: NavigationCoordinator
    private let mediaType: MediaType
    
    init(rootCoordinator: NavigationCoordinator, mediaType: MediaType) {
        self.rootCoordinator = rootCoordinator
        self.mediaType = mediaType
    }
}

extension CategoryViewRouter: Routable {
    
    func routeToCategoryDetails(category: Category) {
        let router = CategoryDetailsViewRouter(rootCoordinator: self.rootCoordinator, category: category)
        rootCoordinator.push(router)
    }
    
    func makeView() -> AnyView {
        let viewModel = CategoryViewModel(router: self, mediaType: self.mediaType)
        let view = CategoryView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

extension CategoryViewRouter {
    
    static func == (lhs: CategoryViewRouter, rhs: CategoryViewRouter) -> Bool {
        return lhs.mediaType == rhs.mediaType
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(mediaType)
    }
    
}

extension CategoryViewRouter {
    static let mock: CategoryViewRouter = .init(rootCoordinator: NavigationRouter(), mediaType: .movie)
}
