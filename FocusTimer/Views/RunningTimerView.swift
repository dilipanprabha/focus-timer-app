//
//  RunningTimerView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 30/07/25.
//

import SwiftUI

struct RunningTimerView: View {
    
    private let controlPanelViewModel = ControlPanelViewModel()
    @Binding var isStart: Bool
    @ObservedObject var timerViewModel: TimerViewModel
    
    
    var body: some View {
        
        VStack(spacing: 15) {
//            CountdownDisplayView(hours: $hours, minutes: $minutes, seconds: $seconds, isStart: $isStart, timerViewModel: timerViewModel)
            CountdownDisplayView(isStart: $isStart, timerViewModel: timerViewModel)
            
            ControlPanelView(title: "Resume", color: .africanVioletCol) {
                controlPanelViewModel.resumeFun(timerViewModel)
            }
                
            ControlPanelView(title: "Stop", color: .africanVioletCol) {
                controlPanelViewModel.stopFun(timerViewModel)
            }
                
            ControlPanelView(title: "Reset", color: .africanVioletCol) {
//                hours = 0
//                minutes = 0
//                seconds = 0
//                timerViewModel.setHour(0)
//                timerViewModel.setMinute(0)
//                timerViewModel.setSecond(0)
                timerViewModel.setTimer(hours: 0, minutes: 0, seconds: 0)
                isStart = false
                controlPanelViewModel.resetFun(timerViewModel)
            }
        }
        
    }
}
