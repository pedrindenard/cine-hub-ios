//
//  Strings.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

enum LocalizedStrings {
    
    static let greeting = String(localized: "greeting")
    
    static func updateLanguage(to language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
}
