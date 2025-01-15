//
//  Category.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

struct Category: Equatable {
    let name: String
    let items: [CategoryItem]
    let type: CategoryType
    
    static func map(name: String, items: [Media], type: String) -> Category {
        let items = items.map { media in CategoryItem.map(name: media.name, imagePath: media.poster) }
        
        return Category(
            name: name,
            items: items,
            type: CategoryType.map(from: type)
        )
    }
    
    
}

struct CategoryItem: Equatable {
    
    let name: String
    let imagePath: String
    
    static func map(name: String, imagePath: String) -> CategoryItem {
        return CategoryItem(
            name: name,
            imagePath: imagePath
        )
    }
    
}

enum CategoryType: Equatable {
    
    case movie
    case tv
    
    static func map(from type: String) -> CategoryType {
        return type == "movie" ? .movie : .tv
    }
    
}
