import SwiftUI

struct HomeGreetingView: View {
    
    @Binding var goal: Int
    @Binding var fade: Bool
    @Binding var greeting: String?
    private let greetingViewModel: GreetingViewModel = GreetingViewModel()
    @AppStorage("dailyFocusGoal") var dailyFocusGoal: Int = 4
    
    var body: some View {
        
        VStack(spacing: 8) {
            Text("\( greeting ?? greetingViewModel.timeBasedGreet() )")
                .font(.title3)
                .fontWeight(.medium)
                .opacity(fade ? 1 : 0)
                .foregroundColor(.primary)
                .animation(.easeInOut(duration: 0.5), value: fade)
            
            Text("🎯 Daily Goal: \( goal ) / \( dailyFocusGoal ) Sessions")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
       
    }
}
