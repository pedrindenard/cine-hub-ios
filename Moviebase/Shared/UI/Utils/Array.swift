//
//  Array.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 22/01/25.
//

extension Array {
    @inlinable mutating func clear() {
        self.removeAll()
    }
}

extension Set {
    @inlinable mutating func clear() {
        self.removeAll()
    }
}

