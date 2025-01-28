//
//  GenresRepositoryImpl.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

class GenresRepositoryImpl: GenresRepository {
    
    @Injected(\.genresService) var service: GenresService
    
    func getGenres(endpoint: Endpoint) async throws -> [Genre] {
        let result = try await service.getGenres(endpoint: endpoint)
        
        if case .success(let success) = result {
            return success
        }
        
        return []
    }
    
}
