//
//  CategoryLocalDataSource.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine

class CategoryServiceImpl: CategoryService {

    func getMedias(endpoint: Endpoint, mediaType: MediaType) -> AnyPublisher<MediaResult, NetworkError> {
        NetworkRequest.queue(method: .GET, endpoint: endpoint)
            .map { (response: MediaResultResponse) in MediaMapper.map(response: response, mediaType: mediaType) }
            .eraseToAnyPublisher()
    }
    
}
