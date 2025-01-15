//
//  NavigationCoordinator.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

private struct NavigationProviderKey: InjectionKey {
    static var currentValue: NavigationCoordinator = NavigationRouter()
}

extension InjectedValues {
    var navigationProvider: NavigationCoordinator {
        get { Self[NavigationProviderKey.self] }
        set { Self[NavigationProviderKey.self] = newValue }
    }
}

protocol NavigationCoordinator {
    
    func push(_ path: any Routable)
    func popLast()
    func popToRoot()
    
}
