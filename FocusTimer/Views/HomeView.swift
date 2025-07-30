//
//  LandingView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 30/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var isStart: Bool
    @State private var hours: String = "00"
    @State private var minutes: String = "00"
    @State private var seconds: String = "00"
    @ObservedObject var timerViewModel: TimerViewModel
    private let controlPanelViewModel = ControlPanelViewModel()
    
    
    var body: some View {
        
        VStack {
            UserInputDisplayView(hours: $hours, minutes: $minutes, seconds: $seconds)
            
            ControlPanelView(title: "Start", color: .mint) {
                
                let hours = Int(hours)!
                let minutes = Int(minutes)!
                let seconds = Int(seconds)!
                
                if hours == 0 && minutes == 0 && seconds == 0 {
                    isStart = false
                    return
                }
                isStart = true
                timerViewModel.setTimer(hours: hours, minutes: minutes, seconds: seconds)
                controlPanelViewModel.resumeFun(timerViewModel)
                
            }
            
            NavigationalView(timerViewModel: timerViewModel)
        }
    }
}
