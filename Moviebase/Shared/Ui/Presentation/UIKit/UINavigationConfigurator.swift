//
//  OnScrollingChangeViewModifier.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 18/01/25.
//

import SwiftUI

private struct NavigationConfigurator: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                self.configure(navigationController)
                #if DEBUG
                print("Successfully obtained navigation controller")
                #endif
            } else {
                #if DEBUG
                print("Failed to obtain navigation controller")
                #endif
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Unused
    }
}

private struct OnScrollingChangeViewModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content.background(NavigationConfigurator { navigationConfigurator in
            navigationConfigurator.hidesBarsOnSwipe = true
        })
    }
    
}

extension View {
    
    @ViewBuilder
    func onScrollHidesBar() -> some View {
        self.modifier(OnScrollingChangeViewModifier())
    }
    
}
