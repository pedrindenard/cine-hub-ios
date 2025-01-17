//
//  ScreenHubApp.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

@main
struct Application: App {
    
    init() {
        let cache = SDImageCache.shared
        
        cache.clearMemory()
        cache.clearDisk()
        
        cache.config.maxMemoryCost = 0 * 1024 * 1024 // 50 MB
        cache.config.maxDiskSize = 0 * 1024 * 1024 // 100 MB
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .init())
//            NavigationView(navigation: .init())
        }
    }
    
}
