//
//  NetworkLogger.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import Foundation

// MARK: Requests
extension NetworkRequest {
    
    static func logRequest(_ request: URLRequest) {
        
        #if DEBUG
        print("\n--> \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                print("\(key): \(value)")
            }
        }
        
        if let body = request.httpBody, let jsonString = String(data: body, encoding: .utf8) {
            print("Body: \(jsonString)")
        }
        
        print("--> END \(request.httpMethod ?? "")\n")
        #endif
        
    }
    
    static func logResponse(_ response: HTTPURLResponse, _ request: URLRequest, _ data: Data?) {
        
        #if DEBUG
        print("<-- HTTP \(response.statusCode) \(request.url?.absoluteString ?? "")")
        
        if let data = data {
            guard let object = try? JSONSerialization.jsonObject(with: data) else {
                return
            }
            
            guard let serializedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]) else {
                return
            }
            
            let prettyJSONString = String(decoding: serializedData, as: UTF8.self)
            print("Response: \(prettyJSONString)")
        }
        
        print("--> END HTTP\n")
        #endif
        
    }
    
}
