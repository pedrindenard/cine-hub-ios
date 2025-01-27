//
//  NavigationView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

struct NavigationView: View {
    
    @StateObject private var rootCoordinator: NavigationRouter = .init()
    
    let navigationStartDestination: (NavigationCoordinator) -> AnyView
    
    var body: some View {
        NavigationRouterView()
            .environmentObject(rootCoordinator)
    }
    
    @ViewBuilder
    private func NavigationRouterView() -> some View {
        NavigationStack(path: $rootCoordinator.paths) {
            navigationStartDestination(rootCoordinator)
                .navigationDestination(for: AnyRoutable.self) { router in router.makeView() }
        }
    }
    
}
