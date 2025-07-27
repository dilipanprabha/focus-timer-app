import SwiftUI
struct TimerView: View {
    
    @State private var hours: Int
    @State private var minutes: Int
    @State private var seconds: Int
    @StateObject var timerViewModel = TimerViewModel()
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        print("Timer View initialized")
    }
    
    var body: some View {
        VStack(spacing: 15) {
            CountdownDisplay(hours: hours, minutes: minutes, seconds: seconds)
                .onReceive(timerViewModel.getTimerPublish()!, perform: {_ in
                        print("onReceive triggered")
                        if timerViewModel.isTimeZero() {
                            timerViewModel.timerStop()
                            return
                        }
                        
                        hours = timerViewModel.currentHour()
                        minutes = timerViewModel.currentMinute()
                        seconds = timerViewModel.currentSecond()
                    })
                    .scaleEffect(timerViewModel.isTimerRun() ? 1.05 : 1)
                    .animation(timerViewModel.isTimerRun() ? .spring(response: 1.0, dampingFraction: 0.8, blendDuration: 0.2).repeatForever(autoreverses: true) : .spring(response: 1.0, dampingFraction: 0.8, blendDuration: 0.2), value: timerViewModel.isTimerRun())
                
                
                ControlPanel(title: "Start", color: .africanVioletCol) {
                    timerViewModel.setTimer(hours: hours, minutes: minutes, seconds: seconds)
                    
                    guard !timerViewModel.isTimerRun() else {
                        print("Alread started")
                        return
                    }
                    
                    if timerViewModel.isTimeZero() {
                        print("All values are zero")
                        return
                    }
                    
                    timerViewModel.timerStart()
                }
                
                ControlPanel(title: "Pause", color: .africanVioletCol) {
                        if !timerViewModel.isTimerRun() {
                            print("Not started yet")
                            return
                        }
                        timerViewModel.timerStop()
                    }
                
                ControlPanel(title: "Reset", color: .africanVioletCol) {
                        timerViewModel.timerReset()
                        if !timerViewModel.isTimerRun() {
                            print("Not started yet")
                            return
                        }
                        timerViewModel.timerStop()
                }
        }
    }
}


#Preview {
    TimerView(hours: 0, minutes: 0, seconds: 10)
}

