//
//  CategoryItemsRouter.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 22/01/25.
//

import SwiftUI

struct CategoryDetailsViewRouter {
    
    private let rootCoordinator: NavigationCoordinator
    private let category: Category
    
    init(rootCoordinator: NavigationCoordinator, category: Category) {
        self.rootCoordinator = rootCoordinator
        self.category = category
    }
    
}

extension CategoryDetailsViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewPager = PagerAsync.fetcher(endpoint: self.category.endpoint)
        let view = CategoryDetailsView(viewPager: viewPager, name: self.category.name)
        return AnyView(view)
    }
    
}

extension CategoryDetailsViewRouter {
    
    static func == (lhs: CategoryDetailsViewRouter, rhs: CategoryDetailsViewRouter) -> Bool {
        return lhs.category.endpoint == rhs.category.endpoint
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(category.endpoint)
    }
    
}

extension CategoryDetailsViewRouter {
    static let mock: CategoryDetailsViewRouter = .init(rootCoordinator: NavigationRouter(), category: Category(name: "Popular Movies", items: [], endpoint: .popularMovies))
}
