//
//  HomeViewModel.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import Combine
import SwiftUI

class CategoryViewModel : ObservableObject {
    
    @Injected(\.categoryRepository) private var repository: CategoryRepository
    
    @Published private(set) var mediaType: MediaType
    @Published private(set) var state: ViewState<[Category]> = .loading
    @Published var isSearching: Bool = false

    private let router: CategoryViewRouter
    
    init(router: CategoryViewRouter, mediaType: MediaType) {
        self.mediaType = mediaType
        self.router = router
        self.getCategories()
    }
    
    func getCategories() {
        Task(priority: TaskPriority.background) {
            await self.updateState(ViewState.loading)
            
            do {
                let categories = try await repository.getCategories(mediaType: mediaType)
                
                if categories.isEmpty {
                    await self.updateState(.error(message: "TMDB server is offline"))
                } else {
                    await self.updateState(.success(result: categories))
                }
            } catch {
                await self.updateState(.error(message: error.localizedDescription))
            }
        }
    }
    
    func navigateToCategoryDetails(_ category: Category) {
        self.router.routeToCategoryDetails(category: category)
    }
    
    @MainActor
    private func updateState(_ newState: ViewState<[Category]>) {
        withAnimation(.easeIn) {
            self.state = newState
        }
    }
    
}

extension CategoryViewModel {
    static let mock: CategoryViewModel = .init(router: CategoryViewRouter.mock, mediaType: .movie)
}
