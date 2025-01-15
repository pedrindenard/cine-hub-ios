//
//  NetworkError.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

enum NetworkError: Error {
    
    case error(Error)
    
    case invalidUrl
    case unauthorized
    case invalidResponse
    case badRequest
    
    case noInternetConnection
    case noData
    
}
