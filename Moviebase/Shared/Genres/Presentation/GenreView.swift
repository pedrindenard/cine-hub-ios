//
//  GenreView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import SwiftUI

struct GenreHView: View {
    
    let name: String
    let perform: () -> Void
    
    var body: some View {
        Text(name)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .genresBackgroundColor(opacity: 0.2)
            .genresStyle(radius: 25)
            .onTapGesture(perform: perform)
    }
    
}

struct GenreVView: View {
    
    let name: String
    let perform: () -> Void
    
    var body: some View {
        Text(name).frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .genresBackgroundColor(opacity: 0.2)
            .genresStyle(radius: 8)
            .onTapGesture(perform: perform)
    }
    
}

private struct GenresStyle: ViewModifier {
    
    private let shape: RoundedRectangle
    
    init(_ radius: CGFloat) {
        self.shape = RoundedRectangle.rect(cornerRadius: radius)
    }
    
    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

private struct GenresBackgroundColor: ViewModifier {
    
    private let color: Color
    
    init(_ opacity: CGFloat) {
        self.color = Color.gray.opacity(opacity)
    }
    
    func body(content: Content) -> some View {
        content.background(color)
    }
    
}

extension View {
    
    func genresBackgroundColor(opacity: CGFloat = 0.2) -> some View {
        self.modifier(GenresBackgroundColor(opacity))
    }
    
    func genresStyle(radius: CGFloat = 25) -> some View {
        self.modifier(GenresStyle(radius))
    }
    
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            GenreHView(name: "War") {}
            GenreHView(name: "Crime") {}
            GenreHView(name: "Documentary") {}
            GenreHView(name: "Politics") {}
            GenreHView(name: "Kids") {}
        }
    }
    
    ScrollView(.vertical, showsIndicators: false) {
        VStack {
            GenreVView(name: "War") {}
            GenreVView(name: "Crime") {}
            GenreVView(name: "Documentary") {}
            GenreVView(name: "Politics") {}
            GenreVView(name: "Kids") {}
        }
    }
}
