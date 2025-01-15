//
//  ViewFactory.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 13/01/25.
//

import SwiftUI

protocol ViewFactory {
    func makeView() -> AnyView
}
