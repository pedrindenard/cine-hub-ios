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
            Tab("Home", systemImage: "house") {
                viewModel
                    .makeCategoryRouter()
                    .makeView()
            }
            
            Tab("Discovery", systemImage: "network") {
                Text("Discovery")
            }
            
            Tab("Search", systemImage: "magnifyingglass") {
                Text("Search")
            }
            
            Tab("Profile", systemImage: "person") {
                Text("Profile")
            }
        }
        .toolbarBackgroundColor()
        .toolbarTint()
    }
}

#Preview {
    HomeView(viewModel: .init())
}
