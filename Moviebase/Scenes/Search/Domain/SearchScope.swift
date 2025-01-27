//
//  SearchScope.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 17/01/25.
//

enum SearchScope: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case multi = "multi"
    case movie = "movie"
    case tv = "tv"
    case person = "person"
    
    var description: String {
        switch self {
        case .multi: LocalizedString.searchMulti
        case .movie: LocalizedString.searchMovie
        case .tv: LocalizedString.searchTv
        case .person: LocalizedString.searchPerson
        }
    }
    
    var endpoint: Endpoint {
        switch self {
        case .multi: Endpoint.searchMulti
        case .movie: Endpoint.searchMovie
        case .tv: Endpoint.searchTv
        case .person: Endpoint.searchPerson
        }
    }
    
}
