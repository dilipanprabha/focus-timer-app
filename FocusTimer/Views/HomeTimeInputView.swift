
import SwiftUI

struct HomeTimeInputView: View {
    
    @Binding var isStart: Bool
    @Binding var hours: String
    @Binding var minutes: String
    @Binding var seconds: String
    @Binding var sessions: [Session]
    @Binding var focusField: HomeUserInputDisplayView.Field?
    @ObservedObject var timerViewModel: TimerViewModel
    private let controlPanelViewModel = ControlPanelViewModel()
    
    var body: some View {
        
        VStack(spacing: 24) {
            HomeUserInputDisplayView(hours: $hours, minutes: $minutes, seconds: $seconds, focusField: $focusField)
            
            HomeStartButtonView() {
                
                hours = hours.isEmpty ? "00" : hours
                minutes = minutes.isEmpty ? "00" : minutes
                seconds = seconds.isEmpty ? "00" : seconds
                
                let hours = Int(hours) ?? 0
                let minutes = Int(minutes) ?? 0
                let seconds = Int(seconds) ?? 0
                
                if hours == 0 && minutes == 0 && seconds == 0 {
                    isStart = false
                    return
                }
                isStart = true
                timerViewModel.setTimer(hours: hours, minutes: minutes, seconds: seconds)
                timerViewModel.timerStart()
            }
            
            HomeSecondaryActionsView(sessions: $sessions , timerViewModel: timerViewModel)
        }
       
    }
}
