//
//  WatchTestAppApp.swift
//  WatchTestApp Watch App
//
//  Created by Максим Евграфов on 20.03.2025.
//

import SwiftUI

@main
struct WatchTestApp_Watch_AppApp: App {
    @StateObject
    private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
