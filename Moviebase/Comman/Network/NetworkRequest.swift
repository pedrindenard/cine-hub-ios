//
//  TMDBService.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Foundation
import Combine

enum NetworkRequest {
    
    private static let apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    
    public enum BaseURL: String {
        case image = "https://image.tmdb.org/t/p/"
        case api = "https://api.themoviedb.org/3/"
    }
    
    public enum Method: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
}

// MARK: Request implementation
extension NetworkRequest {
    
    static func makeRequest<T: Encodable>(method: Method, endpoint: Endpoint, body: T, params: [URLQueryItem]) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: BaseURL.api.rawValue + endpoint.rawValue) else {
            throw NetworkError.invalidUrl
        }
        
        urlComponents.queryItems = language() + params
        
        guard let url = urlComponents.url else { throw NetworkError.invalidUrl }
        
        var request = URLRequest(url: url)
                
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        
        if isAuthenticated {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        } else {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpMethod = method.rawValue
        
        if method != .GET {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
    
    static func performRequest<R: Decodable>(_ request: URLRequest) async throws -> R {
        logRequest(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        
        logResponse(http, request, data)

        if http.statusCode == 401 { throw NetworkError.unauthorized }
        if http.statusCode == 403 { throw NetworkError.unauthorized }
        
        let decoder = JSONDecoder()
        
        if http.statusCode >= 201 {
            return try decoder.decode(R.self, from: data)
        }
        
        if http.statusCode >= 200 {
            return try decoder.decode(R.self, from: data)
        }
        
        throw NetworkError.badRequest
    }
    
}

// MARK: Language implementation
extension NetworkRequest {
    
    private static func language() -> [URLQueryItem] {
        let language = Locale.current.identifier.hasPrefix("pt") ? "pt-BR" : "en-US"
        
        return [
            URLQueryItem(name: "language", value: language)
        ]
    }
    
}
