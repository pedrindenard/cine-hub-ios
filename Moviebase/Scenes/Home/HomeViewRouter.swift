//
//  HomePageRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

class HomeViewRouter {
    private let identifier: UUID = .init()
}

extension HomeViewRouter: Routable {
    
    func makeView() -> AnyView {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        return AnyView(view)
    }
    
}

extension HomeViewRouter {
    
    static func == (lhs: HomeViewRouter, rhs: HomeViewRouter) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
}

extension HomeViewRouter {
    static let mock: HomeViewRouter = .init()
}
