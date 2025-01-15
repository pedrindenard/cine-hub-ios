//
//  ViewState.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

enum ViewState<T: Equatable>: Equatable {
    
    case loading
    case success(result: T)
    case error(message: String)
    
}
