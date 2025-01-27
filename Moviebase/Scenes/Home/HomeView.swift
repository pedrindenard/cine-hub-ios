//
//  ContentView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        TabView {
            Tab(LocalizedString.tabMovie, systemImage: "film") {
                NavigationView { rootCoordinator in
                    viewModel
                        .makeCategoryMovieRouter(rootCoordinator)
                        .makeView()
                }
            }
            
            Tab(LocalizedString.tabTv, systemImage: "tv") {
                NavigationView { rootCoordinator in
                    viewModel
                        .makeCategoryTvRouter(rootCoordinator)
                        .makeView()
                }
            }
            
            Tab(LocalizedString.tabDiscovery, systemImage: "safari") {
                NavigationView { rootCoordinator in
                    viewModel
                        .makeDiscoveryRouter(rootCoordinator)
                        .makeView()
                }
            }
            
            Tab(LocalizedString.tabProfile, systemImage: "person") {
                NavigationView { rootCoordinator in
                    AnyView(EmptyView())
                }
            }
        }
        .toolbarBackgroundStyle()
    }
}

#Preview {
    HomeView(viewModel: .mock)
}
