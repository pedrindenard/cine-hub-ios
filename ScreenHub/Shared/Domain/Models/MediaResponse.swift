//
//  MediaResponse.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

struct MediaResultResponse: Decodable {
    
    let totalResults: Int
    let totalPages: Int
    let results: [MediaResponse]
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
        case page = "page"
    }
    
}

struct MediaResponse: Decodable {
    
    let key: Int
    let popularity: Double?
    let type: String?
    
    let voteAverage: Double?
    let voteCount: Double?
    let backdrop: String?
    let overview: String?
    let poster: String?
    
    let releaseDate: String?
    let title: String?
    
    let airDate: String?
    let name: String?
    
    let department: String?
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case key = "id"
        case popularity = "popularity"
        case type = "media_type"
        
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case backdrop = "backdrop_path"
        case overview = "overview"
        case poster = "poster_path"
        
        case releaseDate = "release_date"
        case title = "title"
        
        case airDate = "first_air_date"
        case name = "name"
        
        case department = "known_for_department"
        case profile = "profile_path"
    }
    
}
