//
//  Category.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

struct CategoryMapper {
    static func map(response: MediaResult) -> [Media] {
        response.results
    }
}
