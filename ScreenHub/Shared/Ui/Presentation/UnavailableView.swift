//
//  Views.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct UnavailableView: View {
    
    private var title: String = LocalizedString.unavailableContentTitle
    private var description: String = LocalizedString.unavailableContentDescription
    private var system: String = "wifi.exclamationmark"
    
    @ScaledMetric private var weight: CGFloat = 1
    @ScaledMetric private var height: CGFloat = 1
    
    private var actions: () -> AnyView
    
    init(title: String, description: String, system: String) {
        self.title = title
        self.description = description
        self.system = system
        self.actions = {
            AnyView(EmptyView())
        }
    }
    
    init(title: String, description: String, action: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.actions = {
            AnyView(UnavailableButtonView(action: action))
        }
    }
    
    init(action: @escaping () -> Void) {
        self.actions = {
            AnyView(UnavailableButtonView(action: action))
        }
    }
    
    init() {
        self.actions = {
            AnyView(EmptyView())
        }
    }
    
    var body: some View {
        ContentUnavailableView {
            Image(systemName: system)
                .font(.largeTitle)
            
            Text(title)
                .padding(.horizontal, 18)
                .padding(.bottom, 8)
                .padding(.top, 16)
        } description: {
            Text(description)
                .padding(.horizontal, 24)
        } actions: {
            actions()
        }
    }
    
}

struct UnavailableButtonView: View {
    
    var text: String = LocalizedString.unavailableContentRetry
    var action: () -> Void

    init(_ text: String, action: @escaping () -> Void) {
        self.action = action
        self.text = text
    }
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(text, action: action).buttonStyle(.borderedProminent)
    }
    
}

#Preview {
    UnavailableView(
        title: "Algo deu errado",
        description: "Tente novamente em alguns instantes",
        system: "wifi.exclamationmark"
    )
}
