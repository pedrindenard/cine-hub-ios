//
//  Optional+Ext.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Double {
    func orEmpty() -> Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Bool {
    func orEmpty() -> Bool {
        return self ?? false
    }
}

extension Optional where Wrapped: ExpressibleByArrayLiteral {
    func orEmpty() -> Wrapped {
        return self ?? []
    }
}
