//
//  DiscoveryView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

import SwiftUI

struct DiscoveryNetworkView: View {
    
    let name: String
    let image: String
    
    let perform: () -> Void
    
    init(name: String, image: String, perform: @escaping () -> Void) {
        self.name = name
        self.image = image
        self.perform = perform
    }
    
    var body: some View {
        VStack {
            AsyncImageView(quality: .small, path: image)
                .asyncImageScaleToFit(.ratio1_1)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .asyncImageBackgroundGray()
                .asyncImageStyle()
            
            AsyncTextView(name: name)
                .padding(.horizontal, 2)
                .padding(.vertical, 0)
        }.onTapGesture {
            perform()
        }
    }
    
    @ViewBuilder
    private func AsyncTextView(name: String) -> some View {
        Text(name)
            .font(.caption)
            .lineLimit(2, reservesSpace: true)
            .bold()
    }
    
}
