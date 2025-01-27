//
//  ShadowModifier.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    
    private let gradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom)
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.8), radius: 2, x: 0, y: 0)
            .foregroundStyle(.white)
            .foregroundStyle(gradient)
    }
}

extension View {
    func shadow() -> some View {
        self.modifier(ShadowModifier())
    }
}
