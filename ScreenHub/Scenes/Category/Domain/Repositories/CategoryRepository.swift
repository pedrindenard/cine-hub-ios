//
//  CategoryRepository.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

protocol CategoryRepository {
    
    func getCategories(mediaType: MediaType) async throws -> [Category]
    
}
