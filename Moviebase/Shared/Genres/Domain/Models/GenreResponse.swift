//
//  GenreResponse.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

struct GenreResultResponse: Decodable {
    
    let genres: [GenreResponse]
    
    enum CCondingKeys: String, CodingKey {
        case genres = "genres"
    }
    
}

struct GenreResponse: Decodable {
    
    let id: Int?
    let name: String?
    
    enum CCondingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
}
