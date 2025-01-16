//
//  MediaMapper.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

struct MediaMapper {
    static func map(response: MediaResponse, mediaType: MediaType) -> Media {
        let releaseDate = response.releaseDate ?? response.airDate ?? ""
        let overview = response.overview ?? response.department ?? ""
        let poster = response.poster ?? response.profile ?? ""
        let name = response.name ?? response.title ?? ""
        
        let type = response.type ?? mediaType.rawValue
        
        return Media(
            key: response.key,
            popularity: response.popularity.orEmpty(),
            type: type,
            voteCount: response.voteCount.orEmpty(),
            voteAverage: response.voteAverage.orEmpty(),
            backdrop: response.backdrop.orEmpty(),
            poster: poster,
            overview: overview,
            releaseDate: releaseDate,
            name: name
        )
    }
    
    static func map(response: MediaResultResponse, mediaType: MediaType) -> MediaResult {
        let results = response.results.map { response in map(response: response, mediaType: mediaType) }
        
        return MediaResult(
            totalResults: response.totalResults,
            totalPages: response.totalPages,
            results: results,
            page: response.page
        )
    }
}

#if DEBUG
extension Media {
    static var preview: Media {
        Media(
            key: 157336,
            popularity: 373.26,
            type: "movie",
            voteCount: 36120,
            voteAverage: 8.4,
            backdrop: "/9REO1DLpmwhrBJY3mYW5eVxkXFM.jpg",
            poster: "/nCbkOyOMTEwlEV0LtCOvCnwEONA.jpg",
            overview: "As reservas naturais da Terra estão chegando ao fim e um grupo de ...",
            releaseDate: "2014-11-05",
            name: "Interestelar"
        )
    }
}
#endif
