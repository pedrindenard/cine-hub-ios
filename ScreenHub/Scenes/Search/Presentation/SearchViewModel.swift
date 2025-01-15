//
//  HomeViewModel.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

class SearchViewModel : ObservableObject {
    
    @Injected(\.searchRouterProvider) private var searchRouter: SearchViewRouter
    
    func pop() {
        self.searchRouter.pop()
    }
    
}
