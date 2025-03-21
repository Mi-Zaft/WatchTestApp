//
//  ContentView.swift
//  WatchTestApp Watch App
//
//  Created by Максим Евграфов on 20.03.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject
    var sessionManager: SessionManager
    
    @ObservedObject
    var viewModel = WatchViewModel()
    
    var body: some View {
        List(viewModel.characterList) { character in
            Text(character.name)
        }
        .onAppear {
            viewModel.getDataFromPhone()
        }
        .onReceive(NotificationCenter.default.publisher(for: .sessionActivated)) { _ in
            viewModel.getDataFromPhone()
        }
    }
}
