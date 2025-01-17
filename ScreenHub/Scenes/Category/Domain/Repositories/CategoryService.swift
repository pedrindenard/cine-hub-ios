//
//  CategoryRepository.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine

protocol CategoryService {
    
    func getMedias(endpoint: Endpoint, mediaType: MediaType) async throws -> Result<MediaResult, NetworkError>
    
}
