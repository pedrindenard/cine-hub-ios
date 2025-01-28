//
//  Geometry.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 20/01/25.
//

import SwiftUI

extension GeometryProxy {
    var height: CGFloat { self.size.height }
    var width: CGFloat { self.size.width }
}

struct RoundedRectangleStyle: ViewModifier {
    
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content.background(
            RoundedRectangle.rect(cornerRadius: cornerRadius).strokeBorder(lineWidth: 1)
        )
    }
}

struct ClipShapeStyle: ViewModifier {
    
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content.clipShape(
            RoundedRectangle.rect(cornerRadius: cornerRadius)
        )
    }
}

struct IgnoreSageAreaStyle: ViewModifier {
    
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        content.ignoresSafeArea(
            SafeAreaRegions.container, edges: edges
        )
    }
}

extension View {
    
    func roundedRectangle(cornerRadius: CGFloat) -> some View {
        self.modifier(RoundedRectangleStyle(cornerRadius: cornerRadius))
    }
    
    func clipShape(cornerRadius: CGFloat) -> some View {
        self.modifier(ClipShapeStyle(cornerRadius: cornerRadius))
    }
    
    func ignoreSafeArea(edges: Edge.Set) -> some View {
        self.modifier(IgnoreSageAreaStyle(edges: edges))
    }
    
}
