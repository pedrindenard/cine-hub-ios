//
//  MainPagination.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import Foundation

@MainActor
class MainPagination<Item: Paginable>: ObservableObject {

    @Published private(set) var state: PagerState = .idle
    @Published private(set) var items: [Item] = []

    @Published var params: [URLQueryItem] = []
    
    private var pages: Int = 1
    private var page: Int = 1

    let fetchItems: (_ params: [URLQueryItem], _ page: Int) async throws -> (items: [Item], pages: Int)
    
    init(fetchItems: @escaping (_ params: [URLQueryItem], _ page: Int) async throws -> (items: [Item], pages: Int)) {
        self.fetchItems = fetchItems
    }
    
    func loadInitial() async {
        guard state != .loadingInitial else { return }
        
        state = .loadingInitial
        page = 1
        
        do {
            let (newItems, pages) = try await fetchItems(params, page)
            self.pages = pages
            
            self.items = newItems
            self.state = newItems.isEmpty ? .endReached : .idle
        } catch {
            self.state = .endErr
        }
    }
    
    func loadMore() async {
        guard state != .loadingMore, page < pages else { return }
        
        state = .loadingMore
        
        do {
            page += 1
            let (newItems, _) = try await fetchItems(params, page)
            
            self.items.append(contentsOf: newItems)
            self.state = newItems.isEmpty ? .endReached : .idle
        } catch {
            self.state = .endErr
        }
    }
    
}
