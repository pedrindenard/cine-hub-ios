//
//  Image+Extension.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import SwiftUI

struct AsyncImageView: View {
    
    @ScaledMetric var height: CGFloat = 105 * 1.5
    @ScaledMetric var width: CGFloat = 105
    
    private let scale: CGFloat = 1 / 4
    
    var size: String = "w185"
    var path: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: "\(BaseURL.image.rawValue)\(size)\(path)"),
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            Group {
                if case .success(let image) = phase {
                    image.frameScaled()
                }
                
                if case .failure = phase {
                    AsyncImageFailure()
                }
                
                if case .empty = phase {
                    AsyncImageLoading()
                }
            }.frame(width: width, height: height)
        }
    }
    
}

// MARK: Image views implementation
extension AsyncImageView {
    
    func AsyncImageFailure() -> some View {
        ZStack {
            ImageBackground()
                .shadow(radius: 2)
            
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: width * scale, height: height * scale)
        }
    }
    
    func AsyncImageLoading() -> some View {
        ZStack {
            ImageBackground()
                .shadow(radius: 2)
            
            ProgressView()
                .scaleEffect(1.2)
        }
    }
    
    func ImageBackground() -> some View {
        Color
            .gray
            .opacity(0.2)
            .scaledToRect(radius: 4)
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

extension Image {
    
    @ViewBuilder
    func frameScaled() -> some View {
        self.resizable()
            .scaledToFit()
            .scaledToRect(radius: 4)
            .shadow(radius: 2)
    }
    
}

// MARK: Image preview
#Preview {
    let items = Array(1...18)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    ScrollView {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(items, id: \.self) { item in
                AsyncImageView(
                    height: .infinity, width: .infinity, size: "w500", path: "/342bly9MqveL65TnEFzx8TTUxcL.jpg"
                ).aspectRation(2/3)
            }
        }
    }.contentMargins(8)
}
