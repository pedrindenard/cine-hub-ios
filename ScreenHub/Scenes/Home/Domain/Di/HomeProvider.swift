//
//  CategoryRepositoryProviderKey.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

private struct HomeRouterProviderKey: InjectionKey {
    static var currentValue: HomeViewRouter = HomeViewRouter()
}

extension InjectedValues {
    
    var homeRouterProvider: HomeViewRouter {
        get { Self[HomeRouterProviderKey.self] }
        set { Self[HomeRouterProviderKey.self] = newValue }
    }
    
}
