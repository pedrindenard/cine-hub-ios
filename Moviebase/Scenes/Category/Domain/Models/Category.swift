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
    let type: CategoryType
    
}

enum CategoryType: Equatable {
    
    case search
    case carrousel
    case banner
    
}
