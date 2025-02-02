//
//  DiscoveryDetailsView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

import SwiftUI

struct DiscoveryDetailsView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject var viewModel: DiscoveryDetailsViewModel
    
    private var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            Array(repeating: GridItem(.flexible()), count: viewModel.discoveryType.compact)
        } else {
            Array(repeating: GridItem(.flexible()), count: viewModel.discoveryType.regular)
        }
    }
    
    var body: some View {
        DiscoveryListView()
            .navigationTitle(viewModel.discoveryType.description)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func DiscoveryListView() -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.items) { item in
                    DiscoveryItemView(item: item)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 4)
            }
            .padding(.horizontal, 16)
        }
        .contentMargins(.horizontal, 0)
        .contentMargins(.vertical, 16)
    }
    
    @ViewBuilder
    private func DiscoveryItemView(item: DiscoveryItem) -> some View {
        if case .companies = viewModel.discoveryType {
            DiscoveryNetworkView(name: item.name, image: item.image) {
                
            }
        } else if case .networks = viewModel.discoveryType {
            DiscoveryNetworkView(name: item.name, image: item.image) {
                
            }
        } else if case .collections = viewModel.discoveryType {
            DiscoveryCollectionView(name: item.name, image: item.image) {
                
            }
        } else if case .keywords = viewModel.discoveryType {
            DiscoveryKeywordView(name: item.name) {
                
            }
        }
    }
}

#Preview {
    DiscoveryDetailsView(viewModel: .mock)
}
