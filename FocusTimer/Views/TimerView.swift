import SwiftUI
struct TimerView: View {
    
    @State private var hours: Int
    @State private var minutes: Int
    @State private var seconds: Int
    @StateObject var timerViewModel: TimerViewModel
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self._timerViewModel = StateObject(wrappedValue: TimerViewModel(hours: hours, minutes: minutes, seconds: seconds))
        print("Timer View initialized")
    }
    
    var body: some View {
        VStack(spacing: 15) {
            CountdownDisplayView(hours: $hours, minutes: $minutes, seconds: $seconds, timerViewModel: timerViewModel)
                
            ControlPanelView(title: "Start", color: .africanVioletCol, hours: $hours, minutes: $minutes, seconds: $seconds, timerViewModel: timerViewModel)
                
            ControlPanelView(title: "Stop", color: .africanVioletCol, hours: $hours, minutes: $minutes, seconds: $seconds, timerViewModel: timerViewModel)
                
            ControlPanelView(title: "Reset", color: .africanVioletCol, hours: $hours, minutes: $minutes, seconds: $seconds, timerViewModel: timerViewModel) 
        }
    }
}


#Preview {
    TimerView(hours: 0, minutes: 1, seconds: 1)
}

