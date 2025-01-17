//
//  View+Ext.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func toolbarBackgroundColor() -> some View {
        self.onAppear {
            let tabAppearance = UITabBarAppearance()
            
            tabAppearance.backgroundColor = .systemGray4.withAlphaComponent(0.4)
            tabAppearance.shadowColor = .gray.withAlphaComponent(0.3)
            
            let offset = UIOffset(horizontal: 0, vertical: 4)
            
            tabAppearance.stackedLayoutAppearance.normal.titlePositionAdjustment = offset
            tabAppearance.stackedLayoutAppearance.selected.titlePositionAdjustment = offset
            
            let tab = UITabBar.appearance()
            
            tab.scrollEdgeAppearance = tabAppearance
            tab.standardAppearance = tabAppearance
        }
    }
    
    @ViewBuilder
    func navigationToolbarVisibility() -> some View {
        self.toolbarVisibility(.hidden)
    }
    
    @ViewBuilder
    func toolbarTint() -> some View {
        self.tint(.blue)
    }
    
}
