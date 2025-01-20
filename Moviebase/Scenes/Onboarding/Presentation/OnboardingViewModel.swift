//
//  OnboardingViewModel.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 20/01/25.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @AppStorage("onboardingViewDisplayed") var onboardingViewDisplayed: Bool = false
    
    @Published var tabIndex: OnboardingTabs = OnboardingTabs.page1
    
    func updateIndex() {
        withAnimation {
            if tabIndex == .page1 { self.tabIndex = .page2 } else
            if tabIndex == .page2 { self.tabIndex = .page3 } else {
                self.onboardingViewDisplayed = true
            }
        }
    }
    
}
