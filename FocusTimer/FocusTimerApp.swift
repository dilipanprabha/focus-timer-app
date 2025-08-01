import SwiftUI

@main
struct FocusTimerApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("goal") private var goal: Int = 0
    @AppStorage("appOpenCount") private var appOpenCount: Int = 0
    @AppStorage("appOpenDate") private var appOpenDate: String = ""
    @AppStorage("appearance") private var appearance: String = "system"
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .preferredColorScheme(
                    appearance == "dark" ? .dark :
                    appearance == "light" ? .light :
                    nil
                )
                .onChange(of: scenePhase) { _, newPhase in
                    if newPhase == .active {
                        handleAppOpen()
                    }
                }
        }
    }
    
    func handleAppOpen() {
        let today = formattedDate(Date())
        
        if appOpenDate == today {
            appOpenCount += 1
        } else {
            appOpenDate = today
            appOpenCount = 1
            goal = 0
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

