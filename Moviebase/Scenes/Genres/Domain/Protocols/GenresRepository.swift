//
//  GenresRepository.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

protocol GenresRepository {
    func getGenres(endpoint: Endpoint) async throws -> [Genre]
}
