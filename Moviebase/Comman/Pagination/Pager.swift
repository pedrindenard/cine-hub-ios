//
//  Paginable.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

typealias Paginable = Identifiable & Equatable

enum PagerState {
    case idle
    
    case loadingInitial
    case loadingMore
    
    case endReached
    case error
}
