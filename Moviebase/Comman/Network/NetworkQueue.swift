//
//  NetworkManager.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine
import Foundation

extension NetworkRequest {
    
    static func queue<T: Encodable, R: Decodable>(method: Method, endpoint: Endpoint, body: T) async throws -> Result<R, NetworkError> {
        return try await queue(method: method, endpoint: endpoint, body: body, params: [])
    }
    
    static func queue<T: Encodable, R: Decodable>(method: Method, endpoint: Endpoint, body: T, params: [URLQueryItem]) async throws -> Result<R, NetworkError> {
        var attempt = 0
        var delay = 1
        
        while attempt < 5 {
            do {
                if NetworkMonitor.shared.isNotConnected { throw NetworkError.noInternetConnection }
                
                let request = try makeRequest(method: method, endpoint: endpoint, body: body, params: params)
                let response: R = try await performRequest(request)
                
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
        
        // This point will never be reached due to the repetition logic above
        let error = NetworkError.badRequest
        return Result.failure(error)
    }
    
    static func queue<R: Decodable>(method: Method, endpoint: Endpoint, params: [URLQueryItem] = []) async throws -> Result<R, NetworkError> {
        return try await queue(method: method, endpoint: endpoint, body: EmptyBody(), params: params)
    }
    
    static func queue<R: Decodable>(method: Method, endpoint: Endpoint, params: [URLQueryItem] = []) async throws -> R {
        var attempt = 0
        var delay = 1
        
        while attempt < 5 {
            do {
                if NetworkMonitor.shared.isNotConnected { throw NetworkError.noInternetConnection }
                
                let request = try makeRequest(method: method, endpoint: endpoint, body: EmptyBody(), params: params)
                let response: R = try await performRequest(request)
                
                return response
            } catch {
                print("Error: \(error.localizedDescription)")
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
