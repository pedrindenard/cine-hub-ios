//
//  PagerState.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import SwiftUI

enum PagerState {
    case idle
    
    case loadingInitial
    case loadingMore
    
    case endReached
    case endErr
}
