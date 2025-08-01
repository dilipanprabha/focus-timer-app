class ControlPanelViewModel {
    
    func resumeFun(_ timerViewModel: TimerViewModel) -> Void {
        
        guard !timerViewModel.isTimerRun() else {
            return
        }
        
        if timerViewModel.isTimeZero() {
            return
        }
        timerViewModel.timerResume()
    }

    func stopFun(_ timerViewModel: TimerViewModel) -> Void {
        if !timerViewModel.isTimerRun() {
            return
        }
        timerViewModel.timerStop()
    }

    func resetFun(_ isVibration: Bool, _ timerViewModel: TimerViewModel) -> Void {
        timerViewModel.timerReset()
        if isVibration {
            timerViewModel.warningVibration()
        }
    }

}
