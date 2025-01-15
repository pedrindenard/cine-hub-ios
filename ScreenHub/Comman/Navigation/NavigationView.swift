//
//  NavigationView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

struct NavigationView: View {
    
    @StateObject var navigation: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $navigation.paths) {
            navigation
                .navigationStartDestination()
                .navigationDestination(for: AnyRoutable.self) { router in router.makeView() }
        }
    }
    
}
