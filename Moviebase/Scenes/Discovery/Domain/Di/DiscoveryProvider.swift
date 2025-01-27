//
//  DiscoveryProvider.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

private struct DiscoveryRepositoryKey: InjectionKey {
    static var currentValue: DiscoveryRepository = DiscoveryRepositoryImpl.init()
}

extension InjectedValues {
    
    var discoveryRepository: DiscoveryRepository {
        get { Self[DiscoveryRepositoryKey.self] }
        set { Self[DiscoveryRepositoryKey.self] = newValue }
    }
    
}
