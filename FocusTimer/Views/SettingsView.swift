//
//  SettingsView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 31/07/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("dailyFocusGoal") private var dailyFocusGoal: Int = 4
    @AppStorage("isVibration") private var isVibration: Bool = true
    @AppStorage("selectedSession") private var selectedSession: String = "25"
    @AppStorage("appearance") private var appearance: String = "system"
    let sessions = ["15", "20", "25", "30"]
    let themes = ["system", "dark", "light"]
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Text("Settings")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            List {
                Section(header: Text("Daily Goals")) {
                    Stepper("Daily Focus Goal: \(dailyFocusGoal)", value: $dailyFocusGoal, in: 1...12)
                }

                Section(header: Text("Session Behavior")) {
                    Toggle("Vibration", isOn: $isVibration)
                    Picker("Default Timer Duration", selection: $selectedSession) {
                        ForEach(sessions, id: \.self) { session in
                            Text("\(session)min")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section(header: Text("Appearance")) {
                    Picker("Dark Mode", selection: $appearance) {
                        ForEach(themes, id: \.self) { theme in
                            Text("\(theme.capitalized)")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section(header: Text("Data")) {
                    Button("View Session History", action: {})
                    Button("Reset All Data", action: {})
                }
            }
            
//            GroupBox(label: Label("About", systemImage: "info.circle")) {
//                Text("Username: John")
//                Text("Email: john@example.com")
//            }
        }
        
    }
}

#Preview {
    SettingsView()
}
