//
//  GenresService.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

protocol GenresService {
    func getGenres(endpoint: Endpoint) async throws -> Result<[Genre], NetworkError>
}
