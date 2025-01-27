//
//  AppRouter.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

protocol NavigationCoordinator {
    func push(_ path: any Routable)
    func popLast()
    func popToRoot()
}

class NavigationRouter: ObservableObject {
    
    @Published var paths: NavigationPath = .init()
    
    private func removeLast() {
        self.paths.removeLast(paths.count)
    }
    
}

extension NavigationRouter: NavigationCoordinator {
    
    func push(_ router: any Routable) {
        self.paths.append(AnyRoutable(router))
    }
    
    func popLast() {
        self.paths.removeLast()
    }
    
    func popToRoot() {
        self.removeLast()
    }
    
}
