//
//  LazyScrollView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 21/01/25.
//

import SwiftUI

struct LazyScrollView<T: Identifiable, Content: View, Pagination: View>: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private let data: [T]
    private let content: (T) -> Content
    private let pagination: () -> Pagination
    
    private var columns: [GridItem] {
        if horizontalSizeClass == .compact {
            Array(repeating: GridItem(.flexible()), count: 3)
        } else {
            Array(repeating: GridItem(.flexible()), count: 6)
        }
    }
    
    init(data: [T], content: @escaping (T) -> Content, @ViewBuilder pagination: @escaping () -> Pagination) {
        self.data = data
        self.content = content
        self.pagination = pagination
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(data) { item in
                    content(item)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                }
            }
            .padding(.horizontal, 16)
            
            pagination()
        }
        .contentMargins(.vertical, 16)
    }
    
}

#if DEBUG

#Preview {
    let items = [Media.preview, Media.preview, Media.preview]
    
    LazyScrollView(data: items) { item in
        Text("\(item.name)")
    } pagination: {
        Text("End of pagination")
    }
}

#endif
