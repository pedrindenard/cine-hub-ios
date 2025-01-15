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
    
    private var publishers: [AnyCancellable] = []
    
    init() {
        startLoading()
        startFetching()
    }
    
    deinit {
        publishers.forEach { publish in publish.cancel() }
    }
    
}

// MARK: Use case implementatino
extension CategoryViewModel {
    
    func startLoading() {
        self.state = ViewState.loading
    }
    
    func startFetching() {
        self.repository.getCategories(type: .movie)
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
            self.state = ViewState.error(message: error.localizedDescription)
        }
    }
    
    private func receiveValue(_ categories: [Category]) {
        if categories.isEmpty {
            self.state = ViewState.error(message: "TMDB server is offline")
        } else {
            self.state = ViewState.success(result: categories)
        }
    }
    
}

// MARK: Navigation implementation
extension CategoryViewModel {
    func navigateToSearch() {
        self.categoryRouter.routeToSearch()
    }
}
