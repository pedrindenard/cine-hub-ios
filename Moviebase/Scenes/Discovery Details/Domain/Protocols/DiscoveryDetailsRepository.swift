//
//  DiscoveryDetailsRepository.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

protocol DiscoveryDetailsRepository {
    func getChannels(from: DiscoveryType) -> [DiscoveryItem]
}
