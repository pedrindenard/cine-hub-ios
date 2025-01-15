//
//  HomeViewModel.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    
    @Injected(\.categoryRouterProvider) private var categoryRouter: CategoryViewRouter
    @Injected(\.homeRouterProvider) private var homeRouter: HomeViewRouter

    func makeCategoryRouter() -> CategoryViewRouter {
        self.categoryRouter
    }
    
    func navigateToSearch() {
        self.homeRouter.routeToSearch()
    }
    
    func pop() {
        self.homeRouter.pop()
    }
    
}
