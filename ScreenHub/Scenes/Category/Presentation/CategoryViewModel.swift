//
//  HomeViewModel.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import Combine
import SwiftUI

@MainActor
class CategoryViewModel : ObservableObject {
    
    @Injected(\.categoryRepositoryProvider) private var repository: CategoryRepository
    @Injected(\.categoryRouterProvider) private var router: CategoryViewRouter
        
    @Published var mediaType: MediaType = MediaType.movie
    @Published var state: ViewState<[Category]> = ViewState.loading

    init(mediaType: MediaType) {
        self.mediaType = mediaType
        self.getCategories()
    }
    
    private func updateCategories() async {
        self.updateState(ViewState.loading)
        
        do {
            let categories = try await repository.getCategories(mediaType: mediaType)
            
            if categories.isEmpty {
                self.updateState(.error(message: "TMDB server is offline"))
            } else {
                self.updateState(.success(result: categories))
            }
        } catch {
            self.updateState(.error(message: error.localizedDescription))
        }
    }
    
    private func updateState(_ newState: ViewState<[Category]>) {
        withAnimation(.easeIn) {
            self.state = newState
        }
    }
    
    func getCategories() {
        Task {
            await self.updateCategories()
        }
    }
    
}
