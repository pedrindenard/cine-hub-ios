//
//  ScreenHubApp.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

@main
struct Application: App {
    
    @AppStorage("onboardingViewDisplayed") private var onboardingViewDisplayed: Bool = false
    
    var body: some Scene {
        WindowGroup {
            WindowContent()
                .animation(.easeInOut, value: onboardingViewDisplayed)
        }
    }
    
    @ViewBuilder
    private func WindowContent() -> some View {
        if onboardingViewDisplayed {
            HomeView()
        } else {
            OnboardingView()
        }
    }
    
}
