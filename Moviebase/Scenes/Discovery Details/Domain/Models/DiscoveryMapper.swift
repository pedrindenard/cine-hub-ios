//
//  DiscoveryMapper.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

struct DiscoveryMapper {
    
    static func map(results: [DiscoveryItemResponse]) -> [DiscoveryItem] {
        return results.map { discovery in
            return DiscoveryItem(id: discovery.id, name: discovery.name, image: discovery.backdrop_path ?? discovery.poster_path ?? discovery.logo_path ?? "")
        }
    }
    
}
