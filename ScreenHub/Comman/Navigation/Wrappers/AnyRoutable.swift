//
//  AnyRoutable.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

// MARK: - A type-erased wrapper for Routable
struct AnyRoutable: Routable {
    
    private let base: any Routable
    private let equals: (any Routable) -> Bool

    init<T: Routable>(_ routable: T) {
        self.base = routable
        self.equals = { other in other as! T == routable }
    }

    func makeView() -> AnyView {
        self.base.makeView()
    }

    func hash(into hasher: inout Hasher) {
        self.base.hash(into: &hasher)
    }

    static func == (lhs: AnyRoutable, rhs: AnyRoutable) -> Bool {
        lhs.equals(rhs.base)
    }

}
