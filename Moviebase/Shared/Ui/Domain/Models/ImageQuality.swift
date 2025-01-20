//
//  ImageQuality.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

enum ImageQuality: CustomStringConvertible {
    
    case custom(width: Int)
    
    /// Original image quality
    case original
    
    /// w1280 image quality
    case large
    
    /// w500 image quality
    case medium
    
    /// w300  image quality
    case small
    
    var dimen: String {
        switch self {
        case .small: "w300"
        case .medium: "w500"
        case .large: "w1280"
        case .original: "original"
        case .custom(let width): "w\(width)"
        }
    }
    
    var description: String {
        return dimen
    }
    
}
