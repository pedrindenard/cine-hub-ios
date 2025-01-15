//
//  CategoryLocalDataSource.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine

class CategoryServiceImpl: CategoryService {

    func getMedias(endpoint: Endpoint) -> AnyPublisher<MediaResult, NetworkError> {
        NetworkRequest.queue(method: .GET, endpoint: endpoint)
            .map { (response: MediaResultResponse) in response.map() }
            .eraseToAnyPublisher()
    }
    
}
