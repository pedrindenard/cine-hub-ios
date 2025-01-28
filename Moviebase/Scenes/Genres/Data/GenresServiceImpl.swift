//
//  GenresServiceImpl.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

class GenresServiceImpl: GenresService {
    
    func getGenres(endpoint: Endpoint) async throws -> Result<[Genre], NetworkError> {
        try await NetworkRequest.queue(baseUrl: .v3, method: .GET, endpoint: endpoint).map { response in
            GenreMapper.map(response: response)
        }
    }
    
}
