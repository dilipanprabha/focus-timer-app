import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 1
    @State private var seconds: Int = 10
    @State private var timerExtract: TimerExtract?
    @State private var cancellable: Cancellable?
    @State private var isTimerRunning = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    private var count: Int = 1
    
    var body: some View {
        
        ZStack {
            Color.onyxCol
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                TimerBox(hours: hours, minutes: minutes, seconds: seconds)
                    .onReceive(timer, perform: {_ in
                        
                        if (minutes == 0 && seconds == 0 && hours == 0) {
                            cancellable?.cancel()
                            isTimerRunning = false
                            timer = Timer.publish(every: 1, on: .main, in: .common)
                            return
                        }
                        
                        hours = timerExtract?.houLimit(count: count) ?? hours
                        minutes = timerExtract?.minLimit(count: count) ?? minutes
                        seconds = timerExtract?.secLimit(count: count) ?? seconds
                    })
                    .scaleEffect(isTimerRunning ? 1.05 : 1)
                    .animation(isTimerRunning ? .spring(response: 1.0, dampingFraction: 0.8, blendDuration: 0.2).repeatForever(autoreverses: true) : .spring(response: 1.0, dampingFraction: 0.8, blendDuration: 0.2), value: isTimerRunning)
                
                
                CustomButton(title: "Start", color: .africanVioletCol) {
                    guard !isTimerRunning else {
                        return
                    }
                    
                    guard !(minutes != 0 && seconds != 0 && hours != 0) else {
                        return
                    }
                    
                    cancellable = timer.connect()
                    isTimerRunning = true
                    timerExtract = TimerExtract(hours: hours, minutes: minutes, seconds: seconds)
                }
                
                CustomButton(title: "Pause", color: .africanVioletCol) {
                    if !isTimerRunning {
                        return
                    }
                    cancellable?.cancel()
                    isTimerRunning = false
                    timer = Timer.publish(every: 1, on: .main, in: .common)
                }
                
                CustomButton(title: "Reset", color: .africanVioletCol) {
                    minutes = 0
                    seconds = 0
                    if !isTimerRunning {
                        return
                    }
                    cancellable?.cancel()
                    isTimerRunning = false
                    timer = Timer.publish(every: 1, on: .main, in: .common)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

