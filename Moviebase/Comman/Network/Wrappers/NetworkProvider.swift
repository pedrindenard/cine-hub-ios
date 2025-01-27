//
//  NetworkProvider.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 22/01/25.
//

import Foundation

struct NetworkProvider {
    
    static func makeRequest<T: Encodable>(method: Method, baseUrl: BaseURL, endpoint: Endpoint, body: T, params: [URLQueryItem]) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseUrl.rawValue + endpoint.rawValue) else {
            throw NetworkError.invalidUrl
        }
        
        urlComponents.queryItems = params
        
        guard let url = urlComponents.url else { throw NetworkError.invalidUrl }
        
        var request = URLRequest(url: url)
                
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        
        if isAuthenticated {
            request.setValue("Bearer \(NetworkRequest.apiKey)", forHTTPHeaderField: "Authorization")
        } else {
            request.setValue("Bearer \(NetworkRequest.apiKey)", forHTTPHeaderField: "Authorization")
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
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        
        logResponse(httpResponse, request, data)

        if httpResponse.statusCode == 401 { throw NetworkError.unauthorized }
        if httpResponse.statusCode == 403 { throw NetworkError.unauthorized }
        
        let decoder = JSONDecoder()
        
        if httpResponse.statusCode >= 201 {
            return try decoder.decode(R.self, from: data)
        }
        
        if httpResponse.statusCode >= 200 {
            return try decoder.decode(R.self, from: data)
        }
        
        throw NetworkError.badRequest
    }
    
    static func getLanguage() -> [URLQueryItem] {
        let language = Locale.current.identifier.hasPrefix("pt") ? "pt-BR" : "en-US"
        
        return [
            URLQueryItem(name: "language", value: language)
        ]
    }
    
}
