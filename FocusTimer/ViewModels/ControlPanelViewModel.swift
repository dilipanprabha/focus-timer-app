//
//  Untitled.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 29/07/25.
//

class ControlPanelViewModel {
    
    func resumeFun(_ timerViewModel: TimerViewModel) -> Void {
    //    timerViewModel.setTimer(hours: hours, minutes: minutes, seconds: seconds)
        
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
        print("reset clicked")
        timerViewModel.timerReset()
        timerViewModel.warningVibration()
    }

}
