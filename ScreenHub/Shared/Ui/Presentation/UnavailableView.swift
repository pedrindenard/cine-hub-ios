//
//  Views.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct UnavailableView: View {
    
    private var title: String
    private var description: String
    
    @ScaledMetric private var weight: CGFloat = 1
    @ScaledMetric private var height: CGFloat = 1
    
    private var actions: () -> AnyView
    
    init(title: String, description: String, @ViewBuilder actions: @escaping () -> some View) {
        self.title = title
        self.description = description
        self.actions = {
            AnyView(actions())
        }
    }
    
    var body: some View {
        ContentUnavailableView {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            
            Text(title)
                .padding(.bottom, 8)
                .padding(.top, 16)
        } description: {
            Text(description)
        } actions: {
            actions()
        }
    }
    
}

struct UnavailableButtonView: View {
    
    var text: String
    var action: () -> Void

    init(_ text: String, action: @escaping () -> Void) {
        self.action = action
        self.text = text
    }
    
    var body: some View {
        Button(text, action: action).buttonStyle(.borderedProminent)
    }
    
}

#Preview {
    UnavailableView(
        title: LocalizedString.unavailableContentTitle,
        description: LocalizedString.unavailableContentDescription
    ) {
        UnavailableButtonView(LocalizedString.unavailableContentRetry) {
            
        }
    }
}
