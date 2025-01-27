//
//  View+Ext.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

struct ToolbarBackgroundColorStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content.onAppear {
            let tabAppearance = UITabBarAppearance()
            
            tabAppearance.backgroundColor = .systemGray4.withAlphaComponent(0.4)
            tabAppearance.shadowColor = .gray.withAlphaComponent(0.3)
            
            let offset = UIOffset(horizontal: 0, vertical: 4)
            
            tabAppearance.stackedLayoutAppearance.normal.titlePositionAdjustment = offset
            tabAppearance.stackedLayoutAppearance.selected.titlePositionAdjustment = offset
            
            let tab = UITabBar.appearance()
            
            tab.scrollEdgeAppearance = tabAppearance
            tab.standardAppearance = tabAppearance
        }.tint(.accent)
    }
}

struct ToolbarAnimation<T: Equatable>: ViewModifier {
    
    let value: T
    
    func body(content: Content) -> some View {
        content.animation(.easeIn(duration: 0.2), value: value)
    }
}

struct ToolbarHidden: ViewModifier {
    
    func body(content: Content) -> some View {
        content.toolbarVisibility(.hidden)
    }
}

extension View {
    
    func toolbarBackgroundStyle() -> some View {
        self.modifier(ToolbarBackgroundColorStyle())
    }
    
    func navigationToolbarVisibility() -> some View {
        self.modifier(ToolbarHidden())
    }
    
    func toolbarAnimation<T: Equatable>(value: T) -> some View {
        self.modifier(ToolbarAnimation(value: value))
    }
    
}
