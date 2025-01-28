//
//  DiscoveryKeywordView.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

import SwiftUI

struct DiscoveryKeywordView: View {
    
    let name: String
    let perform: () -> Void
    
    init(name: String, perform: @escaping () -> Void) {
        self.name = name
        self.perform = perform
    }
    
    var body: some View {
        Text(name).frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .asyncImageBackgroundGray()
            .asyncImageStyle()
            .onTapGesture(perform: perform)
    }
    
}

#Preview {
    DiscoveryKeywordView(name: "civil war") {
        // F
    }
}
