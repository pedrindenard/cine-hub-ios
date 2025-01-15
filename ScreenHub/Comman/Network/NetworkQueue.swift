//
//  NetworkManager.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine
import Foundation

extension NetworkRequest {
    
    static func queue<T: Encodable, R: Decodable>(method: Method, endpoint: Endpoint, body: T) -> Future<R, NetworkError> {
        return queue(method: method, endpoint: endpoint, body: body, params: [])
    }
    
    static func queue<R: Decodable>(method: Method,endpoint: Endpoint, params: [URLQueryItem] = []) -> Future<R, NetworkError> {
        return queue(method: method, endpoint: endpoint, body: EmptyBody(), params: params)
    }
    
    static func queue<T: Encodable, R: Decodable>(method: Method, endpoint: Endpoint, body: T, params: [URLQueryItem]) -> Future<R, NetworkError> {
        return Future { promise in
            Task {
                var attempt = 0
                var delay = 1
                
                while attempt < 5 {
                    do {
                        if NetworkMonitor.shared.isNotConnected { throw NetworkError.noInternetConnection }
                        
                        let request = try makeRequest(method: method, endpoint: endpoint, body: body, params: params)
                        let response: R = try await performRequest(request)
                        
                        promise(Result.success(response))
                        break
                    } catch {
                        attempt += 1
                        
                        if attempt >= 5 {
                            let error = NetworkError.error(error)
                            promise(Result.failure(error))
                            return
                        }
                        
                        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                        delay *= 2
                    }
                }
            }
        }
    }
}
