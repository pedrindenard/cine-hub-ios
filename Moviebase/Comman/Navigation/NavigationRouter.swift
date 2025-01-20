//
//  AppRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

class NavigationRouter: ObservableObject {
    
    @Published var paths: NavigationPath = .init()
    
}

// MARK: NavigationCoordinator implementation
extension NavigationRouter: NavigationCoordinator {
    
    func push(_ router: any Routable) {
        DispatchQueue.main.async {
            let wrappedRouter = AnyRoutable(router)
            self.paths.append(wrappedRouter)
        }
    }
    
    func popLast() {
        DispatchQueue.main.async {
            self.paths.removeLast()
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async {
            self.removeLast()
        }
    }
    
}

// MARK: NavigationCoordinator utils
extension NavigationRouter {
    
    private func removeLast() {
        self.paths.removeLast(paths.count)
    }
    
}

