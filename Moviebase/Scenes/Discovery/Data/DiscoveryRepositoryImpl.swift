//
//  DiscoveryRepositoryImpl.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

class DiscoveryRepositoryImpl: DiscoveryRepository {
    
    func getCategories() -> [Discovery] {
        let categories = [
            Discovery(name: LocalizedString.discoveryMovies, systemName: "film", type: .collections),
            Discovery(name: LocalizedString.discoveryTv, systemName: "tv", type: .collections),
            Discovery(name: LocalizedString.discoveryMovieGenres, systemName: "list.bullet", type: .genresMovie),
            Discovery(name: LocalizedString.discoveryTvGenres, systemName: "list.bullet.rectangle", type: .genresTv),
            Discovery(name: LocalizedString.discoveryPeoples, systemName: "person.2", type: .collections),
            Discovery(name: LocalizedString.discoveryFilter, systemName: "line.horizontal.3.decrease.circle", type: .collections),
            Discovery(name: LocalizedString.discoveryProductionCompanies, systemName: "building.2", type: .companies),
            Discovery(name: LocalizedString.discoveryTvNetworks, systemName: "play.tv", type: .networks),
            Discovery(name: LocalizedString.discoveryCollections, systemName: "square.stack", type: .collections),
            Discovery(name: LocalizedString.discoveryKeywords, systemName: "text.magnifyingglass", type: .keywords)
        ]
        
        return categories
    }
    
}
