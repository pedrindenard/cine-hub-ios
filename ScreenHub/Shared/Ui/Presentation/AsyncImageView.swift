//
//  AsyncImageView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct AsyncImageView: View {
        
    private var frameWidth: CGFloat?
    private var frameHeight: CGFloat?
    
    private var imageAspectRatio: ImageAspectRatio
    private var imageQuality: ImageQuality
    private var imagePath: String
    
    init(width: CGFloat? = nil, height: CGFloat? = nil, aspectRatio: ImageAspectRatio, quality: ImageQuality, path: String) {
        self.frameWidth = width
        self.frameHeight = height
        self.imageAspectRatio = aspectRatio
        self.imageQuality = quality
        self.imagePath = path
    }
    
    init(aspectRatio imageAspectRatio: ImageAspectRatio, quality imageQuality: ImageQuality, path imagePath: String) {
        self.imageAspectRatio = imageAspectRatio
        self.imageQuality = imageQuality
        self.imagePath = imagePath
    }
        
    var body: some View {
        AsyncImage(
            url: URL(string: buildURLString(imageQuality, imagePath)),
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            if case .success(let image) = phase {
                image
                    .resizable()
                    .frameDimension(frameWidth, frameHeight)
                    .frameAspectRatio(scale: imageAspectRatio.ratio)
                    .frameShape(radius: 4)
            } else {
                Color
                    .gray
                    .opacity(0.2)
                    .frameDimension(frameWidth, frameHeight)
                    .frameAspectRatio(scale: imageAspectRatio.ratio)
                    .frameShape(radius: 4)
                    .blur(radius: 2)
            }
        }
    }
}

fileprivate func buildURLString(_ imageQuality: ImageQuality, _ imagePath: String) -> String {
    
    #if DEBUG
    print("Downloading image URL: \(BaseURL.image.rawValue + imageQuality.dimen + imagePath)")
    #endif
    
    return BaseURL.image.rawValue + imageQuality.dimen + imagePath
}

extension View {
    
    @ViewBuilder
    func frameAspectRatio(scale: CGFloat) -> some View {
        self.aspectRatio(
            scale, contentMode: .fill
        )
    }
    
    @ViewBuilder
    func frameShape(radius: CGFloat) -> some View {
        self.clipShape(
            RoundedRectangle.rect(cornerRadius: radius)
        )
    }
    
    @ViewBuilder
    func frameDimension(_ width: CGFloat? = nil, _ height: CGFloat? = nil) -> some View {
        if let width = width, let height = height {
            self.frame(width: width, height: height)
        } else if let width = width {
            self.frame(width: width)
        } else if let height = height {
            self.frame(height: height)
        } else {
            self
        }
    }
    
}

#Preview {
    ScrollView {
        VStack {
            AsyncImageView(aspectRatio: .ratio16_9, quality: .original, path: "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg")
                .padding()
            
            AsyncImageView(aspectRatio: .ratio16_9, quality: .original, path: "")
                .padding()
            
            HStack {
                AsyncImageView(aspectRatio: .ratio2_3, quality: .original, path: "/gFEHva8Csx18hMGJJZ6gi4sFSKR.jpg")
                    .padding()
                
                AsyncImageView(aspectRatio: .ratio2_3, quality: .original, path: "")
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
