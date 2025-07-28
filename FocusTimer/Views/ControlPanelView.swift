import SwiftUI

struct ControlPanelView: View {
    var title: String
    var color: Color
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Button(title) {
            if title.lowercased() == "start" {
                startFun(hours, minutes, seconds, timerViewModel)
            }
            if title.lowercased() == "stop" {
                stopFun(timerViewModel)
            }
            if title.lowercased() == "reset" {
                hours = 0
                minutes = 0
                seconds = 0
                resetFun(timerViewModel)
            }
        }
            .padding()
            .frame(width: 300)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.primary)
            .font(.title2)
            .kerning(5)
            .textCase(.uppercase)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
    }
}

func startFun(_ hours: Int, _ minutes: Int, _ seconds: Int, _ timerViewModel: TimerViewModel) -> Void {
    timerViewModel.setTimer(hours: hours, minutes: minutes, seconds: seconds)
    
    guard !timerViewModel.isTimerRun() else {
        print("Alread started")
        return
    }
    
    if timerViewModel.isTimeZero() {
        print("All values are zero")
        return
    }
    print("start")
    timerViewModel.timerStart()
}

func stopFun(_ timerViewModel: TimerViewModel) -> Void {
    if !timerViewModel.isTimerRun() {
        print("Not started yet")
        return
    }
    print("stop")
    timerViewModel.timerStop()
}

func resetFun(_ timerViewModel: TimerViewModel) -> Void {
    print("reset")
    timerViewModel.timerReset()
}
