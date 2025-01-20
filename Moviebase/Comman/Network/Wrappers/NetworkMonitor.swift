//
//  NetworkMonitor.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

import Network

class NetworkMonitor {
    
    static let shared: NetworkMonitor = .init()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = false
    private(set) var isNotConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            update(path)
        }
        
        monitor
            .start(queue: queue)
            .self
    }
    
    private func update(_ path: NWPath) {
        self.isNotConnected = path.status != .satisfied
        self.isConnected = path.status == .satisfied
    }
    
}
