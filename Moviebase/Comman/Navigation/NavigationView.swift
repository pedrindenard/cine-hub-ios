//
//  NavigationView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

struct NavigationView: View {
    
    @StateObject var navigation: NavigationRouter = .init()
    
    let navigationStartDestination: () -> AnyView
    
    var body: some View {
        NavigationStack(path: $navigation.paths) {
            navigationStartDestination()
                .navigationDestination(for: AnyRoutable.self) { router in router.makeView() }
        }
    }
    
}
