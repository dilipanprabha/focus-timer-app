//
//  TimerViewModel.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 27/07/25.
//
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    private var id: UUID?
    private var count: Int = 1
    private var progress: Double =  0
    private var totalSeconds: Int = 0
    private var isStarted: Bool = false
    private var startTime: Date?
    private var completedTime: Date?
    private var timerExtract: TimerExtract?
    private var sessionViewModel: SessionViewModel = SessionViewModel()
    private var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    private var cancellable: Cancellable?
    @Published private var hours: Int
    @Published private var minutes: Int
    @Published private var seconds: Int
    @Published private var isTimerRunning: Bool = false
    
    init() {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
        print("Empty init: Timer View Model is initialized")
    }
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        print("Parametarized init: Timer View Model is initialized")
    }
    
    func getHour() -> Int {
        return hours
    }
    
    func setHour(_ hour: Int) -> Void {
        print("TimerViewModel: \(hour)hour is set")
        self.hours = hour
    }
    
    func getMinute() -> Int {
        return minutes
    }
    
    func setMinute(_ minute: Int) -> Void {
        print("TimerViewModel: \(minute)minute is set")
        self.minutes = minute
    }
    
    func getSecond() -> Int {
        return seconds
    }
    
    func setSecond(_ second: Int) -> Void {
        print("TimerViewModel: \(second)second is set")
        self.seconds = second
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
        startTime = Date()
        id = UUID()
        cancellable = timer.connect()
        isTimerRunning = true
        isStarted = true
        totalSeconds = totalSeconds == 0 ? (hours * 60 * 60) + (minutes * 60) + seconds : totalSeconds
        timerExtract = TimerExtract(hours: hours, minutes: minutes, seconds: seconds)
        completedTime = timerExtract?.completedAt(startTime!, getCurrentSecond())
        print("Starting Time: \(printTime(startTime!))")
        print("Ending Time: \(printTime(completedTime!))")
        print("Total Seconds: \(totalSeconds)")
    }
    
    // cancel timer and start timer
    func timerStop() -> Void {
        cancellable?.cancel()
        cancellable = nil
        id = nil
        timer = Timer.publish(every: 1, on: .main, in: .common)
        isTimerRunning = false
    }
    
    func timerReset() -> Void {
//        timerExtract?.makeTimerZero()
        isStarted = false
        sessionViewModel.loadSession()
        sessionViewModel.addSession(id!, totalSeconds, completedTime!, false)
        sessionViewModel.saveSession()
        timerStop()
    }
    
    func timerCompleted() -> Void {
        isStarted = false
        sessionViewModel.loadSession()
        sessionViewModel.addSession(id!, totalSeconds, completedTime!, true)
        sessionViewModel.saveSession()
        timerStop()
    }
    
    func isTimerRun() -> Bool {
        return isTimerRunning
    }
    
    func successVibration() -> Void {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
        print("🔔 Success vibrate now!")
    }
    
    func warningVibration() -> Void {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.warning)
        print("🔔 Warning vibrate now!")
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
    
    func printTime(_ date: Date) -> String {
        return date.formatted(date: .complete, time: .complete)
    }
    
    func getTimeString(_ seconds: Int) -> String {
        let time: [Int] = [seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60]
        
        let hour = time[0]
        let minute = time[1]
        let second = time[2]
        
        if (hour != 0 && second != 0) {
            return "\(hour) hr \(minute) min \(second) sec"
        } else if (hour != 0 && second == 0) {
            return "\(hour) hr \(minute) min"
        } else if (minute != 0 && second != 0) {
            return "\(minute) min \(second) sec"
        } else if (minute != 0 && second == 0) {
            return "\(minute) min"
        } else if (second != 0) {
            return "\(second) sec"
        } else {
            return ""
        }
    }
}
