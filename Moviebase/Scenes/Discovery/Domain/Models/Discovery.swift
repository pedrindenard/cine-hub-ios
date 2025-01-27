//
//  Discovery.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 24/01/25.
//

import Foundation

struct Discovery: Equatable, Identifiable {
    
    let id: UUID = UUID()
    
    let name: String
    let systemName: String
    
    let type: DiscoveryType
    
}
