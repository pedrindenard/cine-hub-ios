//
//  Media.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Foundation

struct MediaResult: Equatable {
    
    let totalResults: Int
    let totalPages: Int
    let results: [Media]
    let page: Int
    
}

struct Media: Paginable {
    
    let id: UUID = UUID()
    
    let key: Int
    let popularity: Double
    let type: MediaType
    
    let voteCount: Double
    let voteAverage: Double
    
    let backdrop: String
    let poster: String
    
    let overview: String
    let releaseDate: String
    let name: String
    
}

enum MediaType: String, Paginable {
    
    case person = "person"
    case movie = "movie"
    case tv = "tv"
    
    var id: Self {
        self
    }
    
}
