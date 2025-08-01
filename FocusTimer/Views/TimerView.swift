import SwiftUI

struct TimerView: View {
    
    @State private var isStart: Bool = false
    @StateObject var timerViewModel: TimerViewModel = TimerViewModel()
    
    var body: some View {
        
        if !isStart {
            
            HomeView(isStart: $isStart, timerViewModel: timerViewModel)
            
        } else {
            
            RunningTimerView(isStart: $isStart, timerViewModel: timerViewModel)
            
        }
    }
}

