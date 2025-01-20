//
//  OnboardingView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 18/01/25.
//

import Lottie
import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var viewModel: OnboardingViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.tabIndex) {
                Tab(value: .page1) { Welcome() }
                Tab(value: .page2) { Discovery() }
                Tab(value: .page3) { Explorer() }
            }
            .indexViewStyle(
                PageIndexViewStyle.page(backgroundDisplayMode: .always)
            )
            .tabViewStyle(
                PageTabViewStyle.page(indexDisplayMode: .always)
            )
        }.ignoreSafeArea(edges: .top)
    }
    
    private func Welcome() -> some View {
        OnboardingTabView(
            label: LocalizedString.onboardingLabel1,
            description: LocalizedString.onboardingDescription1,
            namedImageBackground: LocalizedImages.imageOnboarding1,
            namedImageAnimation: LocalizedImages.imageAnimatedOnboarding1,
            buttonLabel: LocalizedString.buttonNext
        ) {
            viewModel.updateIndex()
        }
    }
    
    private func Discovery() -> some View {
        OnboardingTabView(
            label: LocalizedString.onboardingLabel2,
            description: LocalizedString.onboardingDescription2,
            namedImageBackground: LocalizedImages.imageOnboarding2,
            namedImageAnimation: LocalizedImages.imageAnimatedOnboarding2,
            buttonLabel: LocalizedString.buttonNext
        ) {
            viewModel.updateIndex()
        }
    }
    
    private func Explorer() -> some View {
        OnboardingTabView(
            label: LocalizedString.onboardingLabel3,
            description: LocalizedString.onboardingDescription3,
            namedImageBackground: LocalizedImages.imageOnboarding3,
            namedImageAnimation: LocalizedImages.imageAnimatedOnboarding3,
            buttonLabel: LocalizedString.buttonFinish
        ) {
            viewModel.updateIndex()
        }
    }
    
}

#Preview {
    OnboardingView()
}
