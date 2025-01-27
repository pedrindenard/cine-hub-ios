//
//  DiscoveryItemResponse.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

import Foundation

struct DiscoveryItemResponse: Decodable {
        
    let id: Int
    let name: String
    let logo_path: String?
    let backdrop_path: String?
    let poster_path: String?
    
    enum CondingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo_path = "logo_path"
        case backdrop_path = "backdrop_path"
        case poster_path = "poster_path"
    }
    
}
