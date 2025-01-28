//
//  CollectionView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 27/01/25.
//

import SwiftUI

struct DiscoveryCollectionView: View {
    
    let name: String
    let image: String
    
    let perform: () -> Void
    
    init(name: String, image: String, perform: @escaping () -> Void) {
        self.name = name
        self.image = image
        self.perform = perform
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImageView(quality: .medium, path: image)
                .asyncImageScaleToFill(.ratio16_9)
                .asyncImageBackgroundGray()
                .asyncImageStyle()
            
            AsyncTextView(name: name)
                .padding(.horizontal, 2)
                .padding(.vertical, 2)
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

#Preview {
    DiscoveryCollectionView(name: "The Lord of the Rings Collection", image: "/bccR2CGTWVVSZAG0yqmy3DIvhTX.jpg") {
        // F
    }
}
