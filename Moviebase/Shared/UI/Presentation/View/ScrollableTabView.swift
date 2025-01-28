//
//  ScrollableTabView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import SwiftUI

protocol TabContent: Identifiable, Hashable, Equatable {
    var id: UUID { get set }
    
    var size: CGSize { get set }
    var minX: CGFloat { get set }
    
    var name: String { get set }
}

struct ScrollableTabView<Tab: TabContent, Content: View>: View {
    
    private let content: (Tab) -> Content
    
    @State private var tabs: [Tab]
    @State private var tabViewPosition: Tab
    
    @State private var scrollPosition: Tab?
    @State private var tabPosition: Tab?
    
    @State private var progress: CGFloat = .zero
    
    init(tabs: [Tab], @ViewBuilder content: @escaping (Tab) -> Content) {
        self.tabs = tabs
        self.tabViewPosition = tabs.first!
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabBar()
            TabView()
        }
    }
    
    @ViewBuilder
    private func TabBar() -> some View {
        ZStack(alignment: .bottom) {
            TabDivider()
            TabScroll()
                .scrollPosition(id: $tabPosition, anchor: .center)
                .scrollIndicators(.hidden)
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .leading) {
                        let inputRange = tabs.indices.compactMap { indice in CGFloat(indice) }
                        
                        let outputRange = tabs.compactMap { tab in tab.size.width }
                        let outputPositionRange = tabs.compactMap { tab in tab.minX }
                        
                        let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: outputRange)
                        let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(width: .infinity, height: 1)
                            .offset(x: 0)
                        
                        Rectangle()
                            .fill(.primary)
                            .frame(width: indicatorWidth, height: 1.5)
                            .offset(x: indicatorPosition)
                    }
                }
                .safeAreaPadding(.horizontal, 16)
                .safeAreaPadding(.vertical, 0)
        }
    }
    
    @ViewBuilder
    private func TabScroll() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach($tabs) { $tab in
                    Button {
                        withAnimation(.snappy) {
                            self.tabPosition = tab
                            self.tabViewPosition = tab
                            self.scrollPosition = tab
                        }
                    } label: {
                        Label(tab: tab)
                    }
                    .buttonStyle(.plain)
                    .id(tab)
                    .rect { rect in
                        tab.size = rect.size
                        tab.minX = rect.minX
                    }
                }
            }
            .scrollTargetLayout()
        }
    }
    
    @ViewBuilder
    private func TabView() -> some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(tabs) { tab in
                        content(tab)
                            .frame(width: geo.width, height: geo.height)
                            .id(tab)
                    }
                }
                .scrollTargetLayout()
                .rect { rect in
                    self.progress = -rect.minX / geo.width
                }
            }
            .scrollPosition(id: $scrollPosition)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .onChange(of: scrollPosition) { oldTab, newTab in
                if let newTab {
                    withAnimation(.snappy) {
                        self.tabPosition = newTab
                        self.tabViewPosition = newTab
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func Label(tab: Tab) -> some View {
        let size = tabViewPosition.id == tab.id ? 15.0 : 16.0
        let font = tabViewPosition.id == tab.id ? Font.Weight.bold : Font.Weight.regular
        let core = tabViewPosition.id == tab.id ? Color.primary : Color.gray
        
        let system = Font.system(size: size, weight: font)
        
        Text(tab.name)
            .padding(.vertical, 12)
            .foregroundStyle(core)
            .font(system)
    }
    
    @ViewBuilder
    private func TabDivider() -> some View {
        let color = Color.gray.opacity(0.3)
        
        Rectangle()
            .fill(color)
            .frame(height: 1)
    }
}

struct RectKey: PreferenceKey {
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    
    @ViewBuilder
    func rect(completion: @escaping (CGRect) -> ()) -> some View {
        self.overlay {
            GeometryReader { geo in
                let rect = geo.frame(in: .scrollView(axis: .horizontal))
                
                Color.clear
                    .preference(key: RectKey.self, value: rect)
                    .onPreferenceChange(RectKey.self, perform: completion)
            }
        }
    }
}

extension CGFloat {
    
    func interpolate(inputRange: [CGFloat], outputRange: [CGFloat]) -> CGFloat {
        let x = self
        let length = inputRange.count - 1
        
        if x <= inputRange[0] { return outputRange[0] }
        
        for index in 1...length {
            let x1 = inputRange[index - 1]
            let x2 = inputRange[index]
            
            let y1 = outputRange[index - 1]
            let y2 = outputRange[index]
            
            if x <= inputRange[index] {
                let y = y1 + ((y2-y1) / (x2-x1)) * (x-x1)
                return y
            }
        }

        return outputRange[length]
    }
}

#if DEBUG

enum Test {
    case movie
    case tv
    case person
}

struct TabModel: TabContent {
    var id: UUID = .init()
    
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    var name: String
    var type: Test
}

#Preview {
    ScrollableTabView(tabs: [
        TabModel(name: "Movies", type: .movie),
        TabModel(name: "TV Shows", type: .tv),
        TabModel(name: "Persons", type: .person),
        TabModel(name: "Collections", type: .movie),
        TabModel(name: "Networks", type: .person),
        TabModel(name: "Production Companies", type: .tv),
        TabModel(name: "Keywords", type: .movie),
        TabModel(name: "Filters", type: .person),
        TabModel(name: "Movie genres", type: .tv),
        TabModel(name: "TV Shows genres", type: .movie)
    ]) { tab in
        if case .movie = tab.type {
            Text("Movie screen type: \(tab.name)")
        } else if case .tv = tab.type {
            Text("TV Show screen type: \(tab.name)")
        } else if case .person = tab.type {
            Text("Person screen type: \(tab.name)")
        }
    }
}

#endif
