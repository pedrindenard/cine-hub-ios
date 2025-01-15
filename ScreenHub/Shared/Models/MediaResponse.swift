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
    
    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
        case page = "page"
    }
    
    // MARK: Mapper
    func map() -> MediaResult {
        let results = self.results.map { result in result.map() }
        
        return MediaResult(
            totalResults: self.totalResults,
            totalPages: self.totalPages,
            results: results,
            page: self.page
        )
    }
    
}

struct MediaResponse: Decodable {
    
    // Default parameters
    let id: Int
    let popularity: Double?
    let type: String?
    
    // Movie, Tv
    let voteAverage: Double?
    let voteCount: Double?
    let backdrop: String?
    let overview: String?
    let poster: String?
    
    // Movie
    let releaseDate: String?
    let title: String?
    
    // Tv
    let airDate: String?
    let name: String?
    
    // Person
    let department: String?
    let profile: String?
    
    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        
        // Default parameters
        case id = "id"
        case popularity = "popularity"
        case type = "media_type"
        
        // Movie, Tv
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case backdrop = "backdrop_path"
        case overview = "overview"
        case poster = "poster_path"
        
        // Movie
        case releaseDate = "release_date"
        case title = "title"
        
        // Tv
        case airDate = "first_air_date"
        case name = "name"
        
        // Person
        case department = "known_for_department"
        case profile = "profile_path"
        
    }
    
    // MARK: Mapper
    func map() -> Media {
        let releaseDate = self.releaseDate ?? self.airDate ?? ""
        let overview = self.overview ?? self.department ?? ""
        let poster = self.poster ?? self.profile ?? ""
        let name = self.name ?? self.title ?? ""
        
        return Media(
            id: self.id,
            popularity: self.popularity.orEmpty(),
            type: self.type.orEmpty(),
            voteCount: self.voteCount.orEmpty(),
            voteAverage: self.voteAverage.orEmpty(),
            backdrop: self.backdrop.orEmpty(),
            poster: poster,
            overview: overview,
            releaseDate: releaseDate,
            name: name
        )
    }
    
}
