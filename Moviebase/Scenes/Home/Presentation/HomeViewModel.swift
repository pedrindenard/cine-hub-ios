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

    @MainActor
    func makeCategoryMovieRouter() -> AnyView {
        self.categoryRouter.makeView(mediaType: .movie)
    }
    
    @MainActor
    func makeCategoryTvRouter() -> AnyView {
        self.categoryRouter.makeView(mediaType: .tv)
    }
    
    func pop() {
        self.homeRouter.pop()
    }
    
}
