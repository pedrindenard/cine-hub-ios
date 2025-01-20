//
//  MainPagination.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import Foundation

extension MainPagination where Item == Media {
    
    static func fetcher(endpoint: Endpoint) -> MainPagination {
        MainPagination { params, page in
            let response: MediaResultResponse = try await NetworkRequest.queue(method: .GET, endpoint: endpoint, params: params)
            let result = MediaMapper.map(response: response, mediaType: .movie)
            
            return (result.results, response.totalPages)
        }
    }
    
}
