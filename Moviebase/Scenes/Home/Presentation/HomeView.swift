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
                NavigationView {
                    viewModel.makeCategoryMovieRouter()
                }
            }
            
            Tab(LocalizedString.tabTv, systemImage: "tv") {
                NavigationView {
                    viewModel.makeCategoryTvRouter()
                }
            }
            
            Tab(LocalizedString.tabDiscovery, systemImage: "safari") {
                NavigationView {
                    AnyView(EmptyView())
                }
            }
            
            Tab(LocalizedString.tabProfile, systemImage: "person") {
                NavigationView {
                    AnyView(EmptyView())
                }
            }
        }
        .toolbarBackgroundColor()
        .toolbarTint()
    }
}

#Preview {
    HomeView(viewModel: .init())
}
