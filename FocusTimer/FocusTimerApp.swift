//
//  FocusTimerApp.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 26/07/25.
//

import SwiftUI

@main
struct FocusTimerApp: App {
    
    @AppStorage("appearance") private var appearance: String = "system"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appearance == "dark" ? .dark :
                                        appearance == "light" ? .light : nil)
        }
    }
}
