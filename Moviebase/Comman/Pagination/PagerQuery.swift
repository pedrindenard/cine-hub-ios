//
//  PaginationSearch.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 22/01/25.
//

import Foundation
import Combine

class PagerQuery<Item: Paginable>: ObservableObject {
    
    let fetcher: (_ query: String, _ page: Int, _ endpoint: Endpoint) async throws -> (items: [Item], pages: Int)
    
    @Published private(set) var endpoint: Endpoint = .searchMulti
    @Published private(set) var state: PagerState = .idle
    @Published private(set) var items: [Item] = []
    
    private var publishers: Set<AnyCancellable> = Set()
    
    @Published var scope: SearchScope = .multi
    @Published var previousQuery: String = .init()
    @Published var query: String = .init()
    
    private(set) var totalPages: Int = 1
    private(set) var page: Int = 1

    init(fetcher: @escaping (_ query: String, _ page: Int, _ endpoint: Endpoint) async throws -> (items: [Item], pages: Int), endpoint: Endpoint) {
        self.fetcher = fetcher
        self.endpoint = endpoint
    }
    
    func onApper() {
        guard publishers.isEmpty else { return }
        
        self.$query
            .map { [weak self] query in
                let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                guard let self = self else { return trimmedQuery }
                
                if self.previousQuery != trimmedQuery { self.reset(trimmedQuery) }
                self.previousQuery = trimmedQuery
                
                return trimmedQuery
            }
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let self = self else { return }
                self.loadInitial(query)
            }
            .store(in: &publishers)
    }
    
    func loadInitial(_ query: String) {
        Task {
            await self.loadInitial(query)
        }
    }
    
    func updateEndpoint(_ endpoint: Endpoint) {
        Task {
            await self.updateEndpoint(endpoint)
        }
    }
    
    func loadMore() {
        Task {
            await self.loadMore()
        }
    }
    
    func retry() {
        Task {
            await self.loadInitial(previousQuery)
        }
    }
    
    deinit {
        self.publishers.forEach { publisher in publisher.cancel() }
        self.publishers.clear()
    }
    
}

extension PagerQuery {
    
    @MainActor
    private func loadInitial(_ query: String) async {
        guard !query.isEmpty else { return }
        
        do {
            let (newItems, totalPages) = try await fetcher(query, page, endpoint)
            
            self.totalPages = totalPages
            
            self.state = newItems.isEmpty ? .endReached : .idle
            self.items = newItems
        } catch {
            self.state = .error
        }
    }
    
    @MainActor
    private func updateEndpoint(_ endpoint: Endpoint) async {
        self.endpoint = endpoint
        self.reset(query)
        
        await self.loadInitial(query)
    }
    
    @MainActor
    private func loadMore() async {
        guard state != .loadingMore, page < totalPages else { return }
        
        self.state = .loadingMore
        self.page += 1
        
        do {
            let (newItems, _) = try await fetcher(query, page, endpoint)
            
            self.state = newItems.isEmpty ? .endReached : .idle
            self.items.append(contentsOf: newItems)
        } catch {
            self.state = .error
            self.page -= 1
        }
    }
    
    private func reset(_ query: String) {
        self.state = query.isEmpty ? .idle : .loadingInitial
        self.items = []

        self.totalPages = 1
        self.page = 1
    }
    
}
