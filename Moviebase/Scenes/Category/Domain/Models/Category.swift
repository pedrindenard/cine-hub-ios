//
//  Category.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Foundation

struct Category: Equatable, Identifiable {
    
    let id: UUID = UUID()
    
    let name: String
    let items: [Media]
    let endpoint: Endpoint
    
}
