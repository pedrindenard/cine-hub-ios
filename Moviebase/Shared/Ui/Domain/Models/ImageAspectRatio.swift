//
//  ImageAspectRatio.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import Foundation

enum ImageAspectRatio: CustomStringConvertible {
    
    case custom(width: Int, height: Int)
    
    /// 3/2 aspectRatio
    case ratio2_3
    
    /// 3/2 aspectRatio
    case ratio3_2
    
    /// 16/9 aspectRatio
    case ratio16_9
    
    /// 9/16 aspectRatio
    case ratio9_16
    
    /// 4/3 aspectRatio
    case ratio4_3
    
    /// 1/1 aspectRatio
    case ratio1_1
    
    var dimensions: (width: Int, height: Int) {
        switch self {
        case .custom(let width, let height): (width, height)
        case .ratio2_3: (2, 3)
        case .ratio3_2: (3, 2)
        case .ratio16_9: (16, 9)
        case .ratio9_16: (9, 16)
        case .ratio4_3: (4, 3)
        case .ratio1_1: (1, 1)
        }
    }
    
    var ratio: CGFloat {
        let (width, height) = dimensions
        return CGFloat(width) / CGFloat(height)
    }
    
    var description: String {
        let (width, height) = dimensions
        return "\(width):\(height)"
    }
    
}
