import SwiftUI

struct SettingsView: View {
    
    @State private var showSheet = false
    @State private var showAlert = false
    @Binding var sessions: [Session]
    @Binding var minutes: String
    @AppStorage("dailyFocusGoal") private var dailyFocusGoal: Int = 4
    @AppStorage("isVibration") private var isVibration: Bool = true
    @AppStorage("selectedSession") private var selectedSession: String = "25"
    @AppStorage("appearance") private var appearance: String = "system"
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = true
    let sessionsTime = ["15", "20", "25", "30"]
    let themes = ["system", "dark", "light"]
    private let sessionViewModel = SessionViewModel()
    private let goalManager = GoalManager()
    var onDismiss: () -> Void
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Text("Settings")
                .font(.title)
                .bold()
                .padding(.vertical)
            
            List {
                Section(header: Text("Daily Goals")) {
                    Stepper("Daily Focus Goal: \(dailyFocusGoal)", value: $dailyFocusGoal, in: 1...12)
                }

                Section(header: Text("Session Behavior")) {
                    Toggle("Vibration", isOn: $isVibration)
                    Picker("Default Timer Duration", selection: $selectedSession) {
                        ForEach(sessionsTime, id: \.self) { session in
                            Text("\(session)min")
                        }
                    }
                    .pickerStyle(.automatic)
                    .onChange(of: selectedSession) { _,_ in
                        // Update minutes in homeview
                        minutes = selectedSession
                    }
                }
                
                Section(header: Text("Appearance")) {
                    Picker("Appearance", selection: $appearance) {
                        ForEach(themes, id: \.self) { theme in
                            Text("\(theme.capitalized)")
                        }
                    }
                    .pickerStyle(.automatic)
                    .onChange(of: appearance) { _,_ in
                        // Slight delay to allow AppStorage to update
                        if appearance == "system" {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                onDismiss()
                            }
                        }
                    }
                }
                
                Section(header: Text("Data")) {
                    Button("View Session History", action: {
                        showSheet = true
                    })
                    .sheet(isPresented: $showSheet, content: {
                        SessionHistoryView()
                    })
                    Button("Reset All Data", action: {
                        showAlert = true
                    })
                    .alert("Warning", isPresented: $showAlert) {
                        Button("Cancel", role: .cancel) { }
                        Button("Reset", role: .destructive) {
                            reset()
                        }
                    } message: {
                        Text("Are you sure you want to delete all data? This cannot be undone")
                    }
                }
            }
        }
        .preferredColorScheme(
            appearance == "dark" ? .dark :
            appearance == "light" ? .light :
            nil
        )
    }
    
    func reset() -> Void {
        dailyFocusGoal = 4
        selectedSession = "25"
        appearance = "system"
        isVibration = true
        hasSeenOnboarding = false
        goalManager.delAll()
        sessions.removeAll()
        sessionViewModel.deleteAll()
        sessionViewModel.saveSession()
    }
}
