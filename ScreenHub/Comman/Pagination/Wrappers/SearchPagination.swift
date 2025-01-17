//
//  SearchPagination.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import Foundation
import Combine

@MainActor
class SearchPagination<Item: Paginable>: ObservableObject {
    
    let fetcher: (_ query: String, _ page: Int, _ endpoint: Endpoint) async throws -> (items: [Item], pages: Int)
    
    @Published private(set) var state: PagerState = .idle
    @Published private(set) var items: [Item] = []
    @Published private var endpoint: Endpoint
    
    private var publishers: Set<AnyCancellable> = Set()
    
    private var pages: Int = 1
    private var page: Int = 1
    
    @Published var query: String
    
    init(fetcher: @escaping (_ query: String, _ page: Int, _ endpoint: Endpoint) async throws -> (items: [Item], pages: Int), endpoint: Endpoint) {
        self.query = ""
        self.fetcher = fetcher
        self.endpoint = endpoint
    }
    
    func startObservable() {
        guard publishers.isEmpty else { return }
        
        self.$query
            .removeDuplicates()
            .map { [weak self] query in
                self?.items.removeAll()
                
                self?.state = query.isEmpty ? .idle : .loadingInitial
                self?.page = 1
                
                return query
            }
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                Task {
                    await self?.loadInitial(query: query)
                }
            }
            .store(in: &publishers)
    }
    
    deinit {
        self.publishers.forEach { publisher in publisher.cancel() }
    }
    
}

// MARK: Search use case implementation
extension SearchPagination {
    
    func updateEndpoint(_ endpoint: Endpoint) {
        self.endpoint = endpoint
        
        self.items.removeAll()
        
        self.state = query.isEmpty ? .idle : .loadingInitial
        self.page = 1
        
        Task {
            await self.loadInitial(query: query)
        }
    }
    
    func loadInitial(query: String) async {
        guard !query.isEmpty else { return }
        
        do {
            let (newItems, pages) = try await fetcher(query, page, endpoint)
            self.pages = pages
            
            self.items = newItems
            self.state = newItems.isEmpty ? .endReached : .idle
        } catch {
            self.state = .endErr
        }
    }
    
    func loadMore() async {
        guard state != .loadingMore, page < pages else { return }
        
        self.state = .loadingMore
        self.page += 1
        
        do {
            let (newItems, _) = try await fetcher(query, page, endpoint)
            
            self.items.append(contentsOf: newItems)
            self.state = newItems.isEmpty ? .endReached : .idle
        } catch {
            self.state = .endErr
        }
    }
    
}
