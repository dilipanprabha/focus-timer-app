import SwiftUI

struct TimerView: View {
    
//    @State private var hours: Int
//    @State private var minutes: Int
//    @State private var seconds: Int
    @State private var isStart: Bool = false
    @StateObject var timerViewModel: TimerViewModel = TimerViewModel()
    
//    init(hours: Int, minutes: Int, seconds: Int) {
//        self.hours = hours
//        self.minutes = minutes
//        self.seconds = seconds
//        self.isStart = false
//        self._timerViewModel = StateObject(wrappedValue: TimerViewModel(hours: hours, minutes: minutes, seconds: seconds))
//        print("Timer View initialized")
//    }
    
    var body: some View {
        
        NavigationStack {
            if !isStart {
                
                HomeView(isStart: $isStart, timerViewModel: timerViewModel)
                
            } else {
                
                RunningTimerView(isStart: $isStart, timerViewModel: timerViewModel)
                
            }
        }
    }
}


#Preview {
    TimerView()
}

