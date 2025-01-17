//
//  ContentView.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 12/01/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {}.onTapGesture {
            viewModel.pop()
        }
    }
}

#Preview {
    SearchView(viewModel: .init())
}
