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

extension View {
    
    @ViewBuilder
    func roundedRectangle(cornerRadius: CGFloat) -> some View {
        self.background(
            RoundedRectangle.rect(cornerRadius: cornerRadius).strokeBorder(lineWidth: 1)
        )
    }
    
    @ViewBuilder
    func clipShape(cornerRadius: CGFloat) -> some View {
        self.clipShape(
            RoundedRectangle.rect(cornerRadius: cornerRadius)
        )
    }
    
    @ViewBuilder
    func ignoreSafeArea(edges: Edge.Set) -> some View {
        self.ignoresSafeArea(
            SafeAreaRegions.container, edges: edges
        )
    }
    
}
