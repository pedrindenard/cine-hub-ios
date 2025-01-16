//
//  CategoryRepository.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine

protocol CategoryRepository {
    
    func getCategories(mediaType: MediaType) -> AnyPublisher<[Category], NetworkError>
    
}
