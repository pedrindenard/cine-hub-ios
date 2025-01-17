//
//  MediaBanner.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

import SwiftUI

struct MediaBanner: View {
    
    private let backdrop: String
    private let rating: Double
    private let name: String
    
    init(name: String, backdrop: String, rating: Double) {
        self.backdrop = backdrop
        self.rating = rating
        self.name = name
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(aspectRatio: .ratio16_9, quality: .large, path: backdrop)
            AsyncBannerDescription(name: name, rating: rating).padding()
        }
    }
    
    private func AsyncBannerDescription(name: String, rating: Double) -> some View {
        VStack(alignment: .leading) {
            AsyncBannerText(text: name, font: .headline)
            AsyncBannerRating(rating: rating)
        }
    }

    private func AsyncBannerRating(rating: Double) -> some View {
        HStack(alignment: .center) {
            AsyncBannerImage(systemName: "star.fill")
            AsyncBannerText(text: "\(ValueFormatter.formatVoteAverage(rating))", font: .subheadline)
        }
    }

    private func AsyncBannerImage(systemName: String) -> some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 12, height: 12)
            .padding(.bottom, 2)
            .shadow()
    }
    
    private func AsyncBannerText(text: String, font: Font) -> some View {
        Text(text)
            .font(font)
            .lineLimit(1)
            .shadow()
            .bold()
    }
    
}

#Preview {
    MediaBanner(name: "Sonic 3", backdrop: "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg", rating: 9.5)
        .padding(300)
}
