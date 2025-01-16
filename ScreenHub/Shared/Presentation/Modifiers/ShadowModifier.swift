//
//  ShadowModifier.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func shadowStyle() -> some View {
        self.foregroundStyle(
            LinearGradient(
                gradient: Gradient(colors: [.white, .gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    @ViewBuilder
    func shadow() -> some View {
        self.shadow(color: .black.opacity(0.8), radius: 2, x: 0, y: 0)
            .shadowForeground()
            .shadowStyle()
    }
    
    @ViewBuilder
    func shadowForeground() -> some View {
        self.foregroundStyle(.white)
    }
    
}
