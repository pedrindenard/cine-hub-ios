//
//  NetworkManager.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Foundation

extension NetworkRequest {
    
    static func queue<T: Encodable, R: Decodable>(
        baseUrl: BaseURL, method: Method, endpoint: Endpoint, body: T = EmptyBody(), params: [URLQueryItem] = []
    ) async throws -> Result<R, NetworkError> {
        var attempt = 0
        var delay = 1
        
        while attempt < 5 {
            do {
                let request = try NetworkProvider.makeRequest(method: method, baseUrl: baseUrl, endpoint: endpoint, body: body, params: params)
                let response: R = try await NetworkProvider.performRequest(request)
                
                return Result.success(response)
            } catch {
                attempt += 1
                
                if attempt >= 5 {
                    let error = NetworkError.error(error)
                    return Result.failure(error)
                }
                
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                delay *= 2
            }
        }
        
        // This point will never be reached due to the loop logic above
        throw NetworkError.badRequest
    }
    
    static func queue<T: Encodable, R: Decodable>(
        baseUrl: BaseURL, method: Method, endpoint: Endpoint, body: T = EmptyBody(), params: [URLQueryItem] = []
    ) async throws -> R {
        var attempt = 0
        var delay = 1
        
        while attempt < 5 {
            do {
                let request = try NetworkProvider.makeRequest(method: method, baseUrl: baseUrl, endpoint: endpoint, body: body, params: params)
                let response: R = try await NetworkProvider.performRequest(request)
                
                return response
            } catch {
                attempt += 1
                
                if attempt >= 5 {
                    throw NetworkError.error(error)
                }
                
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                delay *= 2
            }
        }
        
        // This point will never be reached due to the repetition logic above
        throw NetworkError.invalidResponse
    }
    
}
