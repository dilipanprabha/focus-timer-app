import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {

        if !hasSeenOnboarding {
            
            OnboardView()
            
        } else {
            
            TimerView()
            
        }
        
    }
}

#Preview {
    ContentView()
}
