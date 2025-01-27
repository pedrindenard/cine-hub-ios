//
//  OnboardingTabView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 20/01/25.
//

import Lottie
import SwiftUI

struct OnboardingTabView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    let label: String
    let description: String
    
    let namedImageBackground: String
    let namedImageAnimation: String
    
    let buttonLabel: String
    let buttonAction: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ImageBackground(proxy: proxy)
                
                VStack {
                    Spacer()
                    
                    ImageAnimated(proxy: proxy)
                    
                    Text(label)
                        .font(.largeTitle)
                        .padding()
                        .shadow()
                    
                    Text(description)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .shadow()
                    
                    ButtonAction()
                        .buttonStyle(.plain)
                        .padding()
                    
                    Spacer()
                    Spacer()
                }
            }
            .frame(maxWidth: proxy.width, maxHeight: proxy.height)
        }
    }
    
    @ViewBuilder
    private func ImageAnimated(proxy: GeometryProxy) -> some View {
        if horizontalSizeClass == .compact {
            LottieView(animation: .named(namedImageAnimation))
                .playing(loopMode: .loop)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: proxy.width / 2)
        }
    }
    
    @ViewBuilder
    private func ImageBackground(proxy: GeometryProxy) -> some View {
        if horizontalSizeClass == .compact {
            Image(namedImageBackground)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: proxy.width, maxHeight: proxy.height)
        }
    }
    
    @ViewBuilder
    private func ButtonAction() -> some View {
        Button(action: buttonAction) {
            Text(buttonLabel)
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .roundedRectangle(cornerRadius: 8)
                .padding()
                .shadow()
        }
    }
}
