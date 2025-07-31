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
    @AppStorage("selectedSession") private var minutes: String = "25"
    @State private var seconds: String = "00"
    @State private var greeting: String?
    @State private var fade = false
    @State private var showSheet = false
    @AppStorage("goal") var goal: Int = 0
    @AppStorage("streak") var streak: Int = 0
    @AppStorage("dailyFocusGoal") private var dailyFocusGoal: Int = 4
    @ObservedObject var timerViewModel: TimerViewModel
    private let greetingViewModel = GreetingViewModel()
    private let controlPanelViewModel = ControlPanelViewModel()
    
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 16) {
                    
    //                ToolBarView()
                    
                    Text("Focus Timer")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        Button(action: {
                            showSheet = true
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "gear")
                                    .font(.system(size: 24))
                                    .foregroundColor(.primary)

                                Text("Settings")
                                    .font(.system(size: 20))
                                    .foregroundColor(.primary)
                            }
                        }
                        .sheet(isPresented: $showSheet) {
                            SettingsView()
                        }
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(.orange)
                                .font(.system(size: 24))
                            Text("Streak: \(streak)")
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        Text("\( greeting ?? greetingViewModel.timeBasedGreet() )")
                            .font(.title3)
                            .fontWeight(.medium)
                            .opacity(fade ? 1 : 0)
                            .foregroundColor(.primary)
                            .animation(.easeInOut(duration: 0.5), value: fade)
                        
                        Text("🎯 Daily Goal: \( goal ) / \( dailyFocusGoal ) Sessions")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.1) // 10% space from top
                    
                    VStack(spacing: 24) {
                        UserInputDisplayView(hours: $hours, minutes: $minutes, seconds: $seconds)
                        
                        StartButton() {
                            let hours = Int(hours) ?? 0
                            let minutes = Int(minutes) ?? 0
                            let seconds = Int(seconds) ?? 0
                            
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

                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    fade = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        fade = false
                        greeting = greetingViewModel.progressBasedGreet(goal)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fade = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        fade = false
                        greeting = greetingViewModel.streakBasedGreet(streak)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fade = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                        let array: [String] = ["Distraction is the enemy of progress.", "Small steps every day lead to big results.", "Silence the noise. Start your focus session."]
                        let random: Int = Int.random(in: 0...2)
                        fade = false
                        greeting = array[random]
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fade = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                        fade = false
                        greeting = greetingViewModel.timeBasedGreet()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fade = true
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
