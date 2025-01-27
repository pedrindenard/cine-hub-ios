//
//  SearchPagination.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import Foundation

extension PagerQuery where Item == Media {
    
    static func fetcher() -> PagerQuery {
        PagerQuery(fetcher: { query, page, endpoint in
            let params = [
                URLQueryItem(name: "query", value: "\(query)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
            let response: MediaResultResponse = try await NetworkRequest.queue(baseUrl: .v3, method: .GET, endpoint: endpoint, params: params)
            let result: MediaResult = MediaMapper.map(response: response, mediaType: .movie)
            
            return (result.results, response.totalPages)
        }, endpoint: .searchMulti)
    }
    
}
