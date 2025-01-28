//
//  Json+Ext.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import Foundation

class JsonReader<T: Decodable> {
    
    static func loadData(from file: String) -> T? {
        do {
            if let filePath = Bundle.main.path(forResource: file, ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let results = try JSONDecoder().decode(T.self, from: data)
                return results
            }
        } catch {
            print("JsonReader: \(error)")
        }
        
        return nil
    }
    
}
