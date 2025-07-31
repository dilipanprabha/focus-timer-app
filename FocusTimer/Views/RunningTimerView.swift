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
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            CountdownDisplayView(isStart: $isStart, timerViewModel: timerViewModel)
            
            VStack(spacing: 15) {
                Button(action: {
                    controlPanelViewModel.resumeFun(timerViewModel)
                }) {
                    Text("RESUME")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    controlPanelViewModel.stopFun(timerViewModel)
                }) {
                    Text("STOP")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                        .foregroundColor(Color.purple)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    timerViewModel.setTimer(hours: 0, minutes: 0, seconds: 0)
                    isStart = false
                    controlPanelViewModel.resetFun(timerViewModel)
                }) {
                    Text("RESET")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            colorScheme == .dark ?
                                Color.purple.opacity(0.6) :
                                Color.purple.opacity(0.3)
                        )
                        .foregroundColor(
                            colorScheme == .dark ? .white : .black
                        )
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
            }
            .padding(.vertical)
        }
    }
}
