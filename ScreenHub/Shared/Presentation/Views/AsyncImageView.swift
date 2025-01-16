//
//  ImageView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct AsyncImageView: View {
    
    var aspectRatio: CGFloat = 2/3
    var quality: String = "w185"
    var path: String
        
    var body: some View {
        WebImage(url: URL(string: "\(BaseURL.image.rawValue)\(quality)\(path)")) { image in
            image.resizable()
                .scaledToFit()
                .aspectRation(aspectRatio)
                .scaledToRect(radius: 4)
                .shadow(radius: 2)
        } placeholder: {
            Color
                .gray
                .opacity(0.2)
                .aspectRation(aspectRatio)
                .scaledToRect(radius: 4)
                .shadow(radius: 2)
            
            ProgressView()
                .scaleEffect(1.2)
        }
        .transition(.fade)
    }
    
}

// MARK: View modifiers
extension View {
    
    @ViewBuilder
    func scaledToRect(radius: CGFloat) -> some View {
        self.clipShape(
            RoundedRectangle.rect(cornerRadius: radius)
        )
    }
    
    @ViewBuilder
    func aspectRation(_ aspect: CGFloat) -> some View {
        self.aspectRatio(aspect, contentMode: .fill)
    }
    
}

// MARK: Image preview
#Preview {
    let items = Array(1...9)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    ScrollView {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(items, id: \.self) { item in
                AsyncImageView(aspectRatio: 2/3, path: "/342bly9MqveL65TnEFzx8TTUxcL.jpg")
            }
        }
    }.contentMargins(8)
}
