//
//  DiscoveryDetailsRepositoryImpl.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

class DiscoveryDetailsRepositoryImpl: DiscoveryDetailsRepository {
    
    func getChannels(from: DiscoveryType) -> [DiscoveryItem] {
        let results = JsonReader<[DiscoveryItemResponse]>.loadData(from: from.rawValue).orEmpty()
        return DiscoveryMapper.map(results: results)
    }
    
}
