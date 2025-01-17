//
//  ContentView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

// Onboarding: TabView com as apresentações [Bem-vindo, Termos e condições, Entrar/Registrar]
//      |-> Termos e condições: Sheet com NavigationStack
//      |-> Entrar/Registrar: Sheet com NavigationStack
//      |-> Home: TabView, cada Tab um NavigationStack
//            |-> Tela principal: NavigationStack
//                  |-> Detalhes: Sheet com NavigationStack
//                  |-> Lista de categorias: TabView
//                          |-> Detalhes: Sheet com NavigationStack
//            |-> Descubra: NavigationStack
//                  |-> Detalhes: Sheet com NavigationStack
//            |-> Bookmark: NavigationStack
//                  |-> Detalhes: Sheet com NavigationStack
//            |-> Trending: NavigationStack
//                  |-> Detalhes: Sheet com NavigationStack
//            |-> Profile: NavigationStack
//                  |-> Termos e condições: Sheet com NavigationStack
//                  |-> Listas: Sheet com NavigationStack
//                          |-> Detalhes: Sheet com NavigationStack
//                  |-> Configurações

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        TabView {
            Tab(LocalizedString.tabMovie, systemImage: "film") {
                viewModel
                    .makeCategoryRouter()
                    .makeView(mediaType: .movie)
            }
            
            Tab(LocalizedString.tabTv, systemImage: "tv") {
                viewModel
                    .makeCategoryRouter()
                    .makeView(mediaType: .tv)
            }
            
            Tab(LocalizedString.tabDiscovery, systemImage: "safari") {
                viewModel
                    .makeCategoryRouter()
                    .makeView(mediaType: .tv)
            }
            
            Tab(LocalizedString.tabProfile, systemImage: "person") {
                viewModel
                    .makeCategoryRouter()
                    .makeView(mediaType: .tv)
            }
        }
        .toolbarBackgroundColor()
        .toolbarTint()
    }
}

#Preview {
    HomeView(viewModel: .init())
}
