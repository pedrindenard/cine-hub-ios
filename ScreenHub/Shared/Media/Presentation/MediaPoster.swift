//
//  Poster.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import SwiftUI

struct MediaPoster: View {
    
    private var name: String
    private var poster: String
    
    private var posterWidth: CGFloat?
    private var posterHeight: CGFloat?
        
    init(width posterWidth: CGFloat? = nil, height posterHeight: CGFloat? = nil, name: String, poster: String) {
        self.posterHeight = posterHeight
        self.posterWidth = posterWidth
        self.poster = poster
        self.name = name

    }
    
    var body: some View {
        AsyncFrameView(name: name, poster: poster)
    }
    
    private func AsyncFrameView(name: String, poster: String) -> some View {
        VStack(alignment: .leading) {
            AsyncImageView(aspectRatio: .ratio2_3, quality: .small, path: poster)
                .frame(width: posterWidth, height: posterHeight)
            
            AsyncTextView(name: name).padding(.horizontal, 2)
                .frame(width: posterWidth, alignment: .leading)
        }
    }
    
    private func AsyncTextView(name: String) -> some View {
        Text(name)
            .font(.caption)
            .lineLimit(2, reservesSpace: true)
            .bold()
    }
    
}


#Preview {
    MediaPoster(width: 120, height: 120 * 3, name: "Ulice", poster: "/gFEHva8Csx18hMGJJZ6gi4sFSKR.jpg")
}
