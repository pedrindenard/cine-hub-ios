//
//  TMDBService.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Foundation

typealias BaseURL = NetworkRequest.BaseURL
typealias Method = NetworkRequest.Method

enum NetworkRequest {
    
    public static let apiKey: String = ProcessInfo.processInfo.environment["API_KEY"].orEmpty()
    
    public enum BaseURL: String {
        case im = "https://image.tmdb.org/t/p/"
        case v3 = "https://api.themoviedb.org/3/"
        case v4 = "https://api.themoviedb.org/4/"
    }
    
    public enum Method: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
}
