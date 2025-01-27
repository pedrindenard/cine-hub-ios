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

    var description: String {
        switch self {
        case .collections: "Collections"
        case .companies: "Companies"
        case .networks: "Networks"
        case .keywords: "Keywords"
        }
    }
    
}
