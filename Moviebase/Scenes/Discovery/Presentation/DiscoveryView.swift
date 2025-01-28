//
//  DiscoveryView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 21/01/25.
//

import SwiftUI

struct DiscoveryView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @StateObject private var viewPager: PagerQuery = .fetcher()
    @StateObject var viewModel: DiscoveryViewModel
    
    private var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            Array(repeating: .init(.flexible()), count: 2)
        } else {
            Array(repeating: .init(.flexible()), count: 4)
        }
    }
    
    var body: some View {
        DiscoveryNavigationView()
            .searchable(text: $viewPager.query, isPresented: $viewModel.isSearching, prompt: LocalizedString.searchPrompt)
            .searchScopes($viewPager.scope) {
                ForEach(SearchScope.allCases) { scope in
                    Text(scope.description)
                }
            }
            .onChange(of: viewPager.scope) { _, scope in
                viewPager.updateEndpoint(scope.endpoint)
            }
    }
    
    @ViewBuilder
    private func DiscoveryNavigationView() -> some View {
        if viewModel.isSearching {
            SearchView(viewPager: viewPager)
                .toolbar(viewPager.query.isEmpty ? .visible : .hidden, for: .tabBar)
                .toolbarAnimation(value: viewPager.query.isEmpty)
        } else {
            DiscoveryListView()
                .contentMargins(.vertical, 16)
        }
    }
    
    @ViewBuilder
    private func DiscoveryListView() -> some View {
        ScrollView(showsIndicators: false) {
            Section {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.items) { discovery in
                        DiscoveryCardView(discovery) {
                            viewModel.navigateTo(discovery.type)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            } header: {
                Text(LocalizedString.discoveryTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .font(.title2)
                    .bold()
            }
        }
    }
    
    @ViewBuilder
    private func DiscoveryCardView(_ discovery: Discovery, perform: @escaping () -> Void) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.ultraThinMaterial)
            
            VStack(alignment: .leading) {
                Image(systemName: discovery.systemName)
                    .imageScale(.medium)
                    .padding(.bottom, 4)
                
                Text(discovery.name)
                    .lineLimit(1)
                    .bold()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .onTapGesture(perform: perform)
        .padding(.horizontal, 8)
        .padding(.bottom, 16)
    }
    
}

#Preview {
    NavigationStack {
        DiscoveryView(viewModel: .mock)
    }
}
