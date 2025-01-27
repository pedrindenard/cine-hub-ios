//
//  AsyncImageView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI

struct AsyncImageView: View {
        
    private(set) var imageQuality: ImageQuality
    private(set) var imagePath: String
    
    init(quality: ImageQuality, path: String) {
        self.imageQuality = quality
        self.imagePath = path
    }
    
    var body: some View {
        AsyncImageCached(url: URL(string: buildURLString(imageQuality, imagePath))) { phase in
            if case .success(let image) = phase {
                image.resizable()
            } else if case .empty = phase {
                progress
            } else if case .failure = phase {
                failure
            }
        }
    }
    
    private var failure: some View {
        Image(systemName: LocalizedImages.systemExclamation)
            .scaleEffect(1.2)
    }
    
    private var progress: some View {
        ProgressView()
            .scaleEffect(1.2)
    }
    
}

private func buildURLString(_ imageQuality: ImageQuality, _ imagePath: String) -> String {
    return BaseURL.im.rawValue + imageQuality.dimen + imagePath
}

private struct AsyncImageScaleToFit: ViewModifier {
    
    private let aspectRatio: CGFloat
    
    init(_ aspectRatio: ImageAspectRatio) {
        self.aspectRatio = aspectRatio.ratio
    }
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
}

private struct AsyncImageScaleToFill: ViewModifier {
    
    private let aspectRatio: CGFloat
    
    init(_ aspectRatio: ImageAspectRatio) {
        self.aspectRatio = aspectRatio.ratio
    }
    
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
}

private struct AsyncImageStyle: ViewModifier {
    
    private let shape: RoundedRectangle = .rect(cornerRadius: 4)
    
    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

private struct AsyncImageBackgroundGray: ViewModifier {
    
    private let color: Color = .gray.opacity(0.2)
    
    func body(content: Content) -> some View {
        content.background(color)
    }
    
}

extension View {
    
    func asyncImageScaleToFill(_ aspectRatio: ImageAspectRatio) -> some View {
        self.modifier(AsyncImageScaleToFill(aspectRatio))
    }
    
    func asyncImageScaleToFit(_ aspectRatio: ImageAspectRatio) -> some View {
        self.modifier(AsyncImageScaleToFit(aspectRatio))
    }
    
    func asyncImageBackgroundGray() -> some View {
        self.modifier(AsyncImageBackgroundGray())
    }
    
    func asyncImageStyle() -> some View {
        self.modifier(AsyncImageStyle())
    }
    
}
