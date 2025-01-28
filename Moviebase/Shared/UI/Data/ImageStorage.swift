//
//  ImageStorage.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 23/01/25.
//

import SwiftUI

struct AsyncImageCached<Content: View>: View {
    
    @StateObject private var asyncImageLoader: AsyncImageLoader = .init()
    
    let content: (AsyncImagePhase) -> Content
    let url: URL?
    
    init(url: URL?, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.content = content
        self.url = url
    }
    
    var body: some View {
        content(asyncImageLoader.phase)
            .task { await asyncImageLoader.load(url) }
    }
}

private class AsyncImageLoader: ObservableObject {
    
    @Published private(set) var phase: AsyncImagePhase = .empty
    
    private let animation: Animation = .easeInOut
    
    private static let cache: URLCache = {
        let memoryCapacity = 100 * 1024 * 1024 // 100 MB memory capacity
        let diskCapacity = 500 * 1024 * 1024 // 500 MB disk capacity
        return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "cache")
    }()
    
}

extension AsyncImageLoader {
    
    func load(_ url: URL?) async {
        await MainActor.run { self.phase = AsyncImagePhase.empty }
        
        guard let url else { return await self.badURL() }
                
        let request = URLRequest(url: url)
        
        if let cachedResponse = AsyncImageLoader.cache.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            return await self.onPhaseSuccess(cachedImage)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw self.badServerResponse() }
            if httpResponse.statusCode != 200 { throw self.badServerResponse() }
            
            if let image = UIImage(data: data) {
                let cached = CachedURLResponse(response: response, data: data)
                AsyncImageLoader.cache.storeCachedResponse(cached, for: request)
                await self.onPhaseSuccess(image)
            } else {
                throw self.cannotDecodeContentData()
            }
            
        } catch {
            await self.onPhaseFailure(error)
        }
    }
    
}

extension AsyncImageLoader {
    
    private func onPhaseSuccess(_ uiImage: UIImage) async {
        let success = AsyncImagePhase.success(Image(uiImage: uiImage))
        await self.onPhaseChanged(success)
    }
    
    private func onPhaseFailure(_ error: Error) async {
        let error = AsyncImagePhase.failure(error)
        await self.onPhaseChanged(error)
    }
    
    @MainActor
    private func onPhaseChanged(_ newPhase: AsyncImagePhase) {
        withAnimation(animation) {
            self.phase = newPhase
        }
    }
    
}

extension AsyncImageLoader {
    
    private func cannotDecodeContentData() -> URLError {
        URLError(URLError.Code.cannotDecodeContentData)
    }
    
    private func badServerResponse() -> URLError {
        URLError(URLError.Code.badServerResponse)
    }
    
}

extension AsyncImageLoader {
    
    private func badURL() async {
        let URLError = URLError(URLError.Code.badURL)
        await self.onPhaseFailure(URLError)
    }
    
}
