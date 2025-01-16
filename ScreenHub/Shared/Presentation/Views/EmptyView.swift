//
//  Views.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct EmptyView: View {
    
    private var title: String
    private var description: String
    
    @ScaledMetric private var weight: CGFloat = 1
    @ScaledMetric private var height: CGFloat = 1
    
    private var view: () -> AnyView
    
    init(title: String, description: String, @ViewBuilder view: @escaping () -> some View) {
        self.title = title
        self.description = description
        self.view = {
            AnyView(view())
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 36 * weight, height: 36 * height)
            
            Text(title)
                .font(.system(.body).bold())
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 40)
                .padding(.top, 8)
            
            Text(description)
                .font(.system(.subheadline))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 48)
                .padding(.bottom, 16)
            
            view()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

#Preview {
    EmptyView(
        title: "No Data Available",
        description: "We couldn't find any data to display.\nPlease try again later."
    ) {
        Button("Retry") { }.buttonStyle(.bordered)
    }
}
