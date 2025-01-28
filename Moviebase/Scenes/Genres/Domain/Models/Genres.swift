//
//  Genres.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

enum Genres {
    
    case movie
    case tv
    
    var description: String {
        switch self {
        case .movie: LocalizedString.discoveryMovieGenres
        case .tv: LocalizedString.discoveryTvGenres
        }
    }
    
    var endpoint: Endpoint {
        switch self {
        case .movie: .genresMovie
        case .tv: .genresTv
        }
    }
    
}

extension DiscoveryType {
    var genres: Genres {
        self == .genresMovie ? .movie : .tv
    }
}
