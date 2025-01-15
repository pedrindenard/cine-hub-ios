//
//  CategoryRepositoryProviderKey.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

private struct SearchRouterProviderKey: InjectionKey {
    static var currentValue: SearchViewRouter = SearchViewRouter()
}

extension InjectedValues {
    
    var searchRouterProvider: SearchViewRouter {
        get { Self[SearchRouterProviderKey.self] }
        set { Self[SearchRouterProviderKey.self] = newValue }
    }
    
}
