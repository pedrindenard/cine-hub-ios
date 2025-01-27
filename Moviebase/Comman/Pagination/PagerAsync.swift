//
//  MainPagination.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import Foundation

class PagerAsync<Item: Paginable>: ObservableObject {

    let fetchItems: (_ params: [URLQueryItem], _ page: Int) async throws -> (items: [Item], pages: Int)

    @Published private(set) var state: PagerState = .idle
    @Published private(set) var items: [Item] = []

    @Published var params: [URLQueryItem] = []
    
    private var totalPages: Int = 1
    private var page: Int = 1
    
    init(fetchItems: @escaping (_ params: [URLQueryItem], _ page: Int) async throws -> (items: [Item], pages: Int)) {
        self.fetchItems = fetchItems
        self.loadInitial()
    }
    
    func loadInitial() {
        Task {
            await self.loadInitial()
        }
    }
    
    func loadMore() {
        Task {
            await self.loadMore()
        }
    }
    
}

extension PagerAsync {
    
    @MainActor
    private func loadInitial() async {
        guard state != .loadingInitial else { return }
        
        self.state = .loadingInitial
        self.page = 1
        
        do {
            let (newItems, totalPages) = try await fetchItems(params, page)
            
            self.totalPages = totalPages
            
            self.state = newItems.isEmpty ? .endReached : .idle
            self.items = newItems
        } catch {
            self.state = .error
        }
    }
    
    @MainActor
    private func loadMore() async {
        guard state != .loadingMore, page < totalPages else { return }
        
        self.state = .loadingMore
        self.page += 1
        
        do {
            let (newItems, _) = try await fetchItems(params, page)
            
            self.state = newItems.isEmpty ? .endReached : .idle
            self.items.append(contentsOf: newItems)
        } catch {
            self.state = .error
            self.page -= 1
        }
    }
    
}

extension PagerAsync where Item == Media {
    
    static func fetcher(endpoint: Endpoint) -> PagerAsync {
        PagerAsync { params, page in
            let params = [
                URLQueryItem(name: "page", value: "\(page)")
            ] + params
            
            let response: MediaResultResponse = try await NetworkRequest.queue(baseUrl: .v3, method: .GET, endpoint: endpoint, params: params)
            let result = MediaMapper.map(response: response, mediaType: .movie)
            
            return (result.results, response.totalPages)
        }
    }
    
}
