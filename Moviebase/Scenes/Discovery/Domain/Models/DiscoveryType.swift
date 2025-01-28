//
//  DiscoveryType.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

enum DiscoveryType: String {
    
    case collections = "collections"
    case companies = "companies"
    
    case networks = "networks"
    case keywords = "keywords"
    
    case genresMovie = "genres_movie"
    case genresTv = "genres_tv"
    
    var description: String {
        switch self {
        case .collections: LocalizedString.discoveryCollections
        case .companies: LocalizedString.discoveryProductionCompanies
        case .networks: LocalizedString.discoveryTvNetworks
        case .keywords: LocalizedString.discoveryKeywords
        default: ""
        }
    }
    
    var compact: Int {
        switch self {
        case .collections: 2
        case .companies: 3
        case .networks: 3
        default: 1
        }
    }
    
    var regular: Int {
        switch self {
        case .collections: 4
        case .companies: 6
        case .networks: 6
        default: 2
        }
    }
    
}
