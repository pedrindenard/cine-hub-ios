//
//  LoadingView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import Lottie
import SwiftUI

struct LoadingView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @ScaledMetric private var weight: CGFloat = 100
    @ScaledMetric private var height: CGFloat = 100
    
    var body: some View {
        let animationName = colorScheme == .dark ? "PointsDark" : "PointsLight"
        
        LottieView(animation: .named(animationName))
            .playing(loopMode: .loop)
            .frame(width: weight, height: height)
    }
    
}

#Preview {
    LoadingView()
}
