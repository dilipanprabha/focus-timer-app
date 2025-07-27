//
//  TimerViewModel.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 27/07/25.
//
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    private var count: Int
    var hours: Int
    var minutes: Int
    var seconds: Int
    private var timerExtract: TimerExtract?
    private var timer: Timer.TimerPublisher
    @Published private var cancellable: Cancellable?
    @Published var isTimerRunning: Bool
    
    init() {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
        self.count = 1
        self.isTimerRunning = false
        timer = Timer.publish(every: 1, on: .main, in: .common)
        print("Timer View Model is initialized")
    }
    
    // return current hour
    func currentHour() -> Int {
        hours = timerExtract?.houLimit(count: count) ?? hours
        return hours
    }
    
    // return current minute
    func currentMinute() -> Int {
        minutes = timerExtract?.minLimit(count: count) ?? minutes
        return minutes
    }
    
    // return current second
    func currentSecond() -> Int {
        seconds = timerExtract?.secLimit(count: count) ?? seconds
        return seconds
    }
    
    // set hours, minutes, and seconds
    func setTimer(hours: Int, minutes: Int, seconds: Int) -> Void {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func getTimerPublish() -> Timer.TimerPublisher? {
        return timer
    }
    
    // start Timer Publish, connect it, and extract timerExtract
    func timerStart() -> Void {
        cancellable = timer.connect()
        isTimerRunning = true
        timerExtract = TimerExtract(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    // cancel timer and start timer
    func timerStop() -> Void {
        cancellable?.cancel()
        cancellable = nil
        isTimerRunning = false
    }
    
    // set hours, minutes, and seconds into zero
    func timerReset() -> Void {
        hours = 0
        minutes = 0
        seconds = 0
    }
    
    func isTimerRun() -> Bool {
        return isTimerRunning
    }
    
    func isTimeZero() -> Bool {
        return (minutes == 0 && seconds == 0 && hours == 0)
    }
}
