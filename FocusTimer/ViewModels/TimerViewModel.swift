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
    private var hours: Int
    private var minutes: Int
    private var seconds: Int
    private var progress: Double
    private var totalSeconds: Int
    private var isStarted: Bool
    private var timerExtract: TimerExtract?
    private var timer: Timer.TimerPublisher
    private var cancellable: Cancellable?
    @Published private var isTimerRunning: Bool
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.count = 1
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.progress = 0
        self.isStarted = false
        self.totalSeconds = (hours * 60 * 60) + (minutes * 60) + seconds
        self.isTimerRunning = false
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
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
        isStarted = true
        timerExtract = TimerExtract(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    // cancel timer and start timer
    func timerStop() -> Void {
        cancellable?.cancel()
        cancellable = nil
        timer = Timer.publish(every: 1, on: .main, in: .common)
        isTimerRunning = false
    }
    
    // set hours, minutes, and seconds into zero
    func timerReset() -> Void {
        timerExtract?.makeTimerZero()
        isStarted = false
        timerStop()
    }
    
    func isTimerRun() -> Bool {
        return isTimerRunning
    }
    
    func isTimeZero() -> Bool {
        return (minutes == 0 && seconds == 0 && hours == 0)
    }
    
    // helper function for getProgress
    func getCurrentSecond() -> Int {
        return timerExtract?.getCurrentSecond() ?? 0
    }
    
    func getProgress() -> CGFloat {
        if !isStarted {
            return 0
        }
        progress = Double(totalSeconds - getCurrentSecond()) / Double(totalSeconds)
        return progress
    }
    
    func getPrecen() -> Int {
        if !isStarted {
            return 0
        }
        return 100 - Int((Double(getCurrentSecond()) / Double(totalSeconds)) * Double(100))
    }
}
