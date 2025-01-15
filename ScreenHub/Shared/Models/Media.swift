//
//  Media.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

struct MediaResult {
    
    let totalResults: Int
    let totalPages: Int
    let results: [Media]
    let page: Int
    
}

struct Media {
    
    let id: Int
    let popularity: Double
    let type: String

    let voteCount: Double
    let voteAverage: Double

    let backdrop: String
    let poster: String

    let overview: String
    let releaseDate: String
    let name: String
    
}
