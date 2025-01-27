//
//  DiscoveryDetailsProvider.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

private struct DiscoveryDetailsRepositoryKey: InjectionKey {
    static var currentValue: DiscoveryDetailsRepository = DiscoveryDetailsRepositoryImpl.init()
}

extension InjectedValues {
    
    var discoveryDetailsRepository: DiscoveryDetailsRepository {
        get { Self[DiscoveryDetailsRepositoryKey.self] }
        set { Self[DiscoveryDetailsRepositoryKey.self] = newValue }
    }
    
}
