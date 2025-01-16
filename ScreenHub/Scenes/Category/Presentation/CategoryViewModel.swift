//
//  HomeViewModel.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import Combine
import SwiftUI

class CategoryViewModel : ObservableObject {
    
    @Injected(\.categoryRepositoryProvider) private var repository: CategoryRepository
    @Injected(\.categoryRouterProvider) private var categoryRouter: CategoryViewRouter
    
    @Published var state: ViewState<[Category]> = ViewState.loading
    @Published var mediaType: MediaType = MediaType.movie
    
    private var publishers: [AnyCancellable] = []
    
    init(mediaType: MediaType) {
        self.mediaType = mediaType
        
        startLoading()
        startFetching()
    }
    
    private func updateState(_ newState: ViewState<[Category]>) {
        withAnimation(.easeIn) {
            self.state = newState
        }
    }
    
    deinit {
        publishers.forEach { publish in publish.cancel() }
    }
    
}

// MARK: Use case implementatino
extension CategoryViewModel {
    
    func startLoading() {
        updateState(ViewState.loading)
    }
    
    func startFetching() {
        self.repository.getCategories(mediaType: mediaType)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in self?.receiveCompletion(completion) },
                receiveValue: { [weak self] categories in self?.receiveValue(categories) }
            )
            .store(in: &publishers)
    }
    
}

// MARK: Network callback implementation
extension CategoryViewModel {
    
    private func receiveCompletion(_ completion: Subscribers.Completion<NetworkError>) {
        if case .failure(let error) = completion {
            updateState(ViewState.error(message: error.localizedDescription))
        }
    }
    
    private func receiveValue(_ categories: [Category]) {
        if categories.isEmpty {
            updateState(ViewState.error(message: "TMDB server is offline"))
        } else {
            updateState(ViewState.success(result: categories))
        }
    }
    
}

// MARK: Navigation implementation
extension CategoryViewModel {
    func navigateToSearch() {
        self.categoryRouter.routeToSearch()
    }
}
