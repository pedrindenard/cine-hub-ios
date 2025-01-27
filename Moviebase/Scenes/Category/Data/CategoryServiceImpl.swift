//
//  CategoryLocalDataSource.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

class CategoryServiceImpl: CategoryService {

    func getMedias(endpoint: Endpoint, mediaType: MediaType) async throws -> Result<MediaResult, NetworkError> {
        try await NetworkRequest.queue(baseUrl: .v3, method: .GET, endpoint: endpoint).map { response in
            MediaMapper.map(response: response, mediaType: mediaType)
        }
    }
    
}
