import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    private var count: Int = 1
    private var progress: Double =  0
    private var totalSeconds: Int = 0
    private var isStarted: Bool = false
    private var startTime: Date? = nil
    private var completedTime: Date?
    private var timerExtract: TimerExtract?
    private var sessionViewModel: SessionViewModel = SessionViewModel()
    private var goalManager: GoalManager = GoalManager()
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
    }
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func getHour() -> Int {
        return hours
    }
    
    func setHour(_ hour: Int) -> Void {
        self.hours = hour
    }
    
    func getMinute() -> Int {
        return minutes
    }
    
    func setMinute(_ minute: Int) -> Void {
        self.minutes = minute
    }
    
    func getSecond() -> Int {
        return seconds
    }
    
    func setSecond(_ second: Int) -> Void {
        self.seconds = second
    }
    
    func getCompletedTime() -> Date {
        return completedTime!
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
        progress = 0
        isStarted = true
        startTime = Date()
        isTimerRunning = true
        cancellable = timer.connect()
        totalSeconds = (hours * 60 * 60) + (minutes * 60) + seconds
        timerExtract = TimerExtract(hours: hours, minutes: minutes, seconds: seconds)
        completedTime = timerExtract?.completedAt(startTime!, getCurrentSecond())
    }
    
    func timerResume() -> Void {
        isTimerRunning = true
        cancellable = timer.connect()
    }
    
    // cancel timer and start timer
    func timerStop() -> Void {
        cancellable?.cancel()
        cancellable = nil
        timer = Timer.publish(every: 1, on: .main, in: .common)
        isTimerRunning = false
    }
    
    func timerReset() -> Void {
        isStarted = false
        sessionViewModel.loadSession()
        sessionViewModel.addSession(totalSeconds, startTime!, false)
        sessionViewModel.saveSession()
        timerStop()
    }
    
    func timerCompleted() -> Void {
        isStarted = false
        
        sessionViewModel.loadSession()
        sessionViewModel.addSession(totalSeconds, completedTime!, true)
        sessionViewModel.saveSession()
        goalManager.goalAdd(totalSeconds)
        goalManager.isReached()
        timerStop()
    }
    
    func isTimerRun() -> Bool {
        return isTimerRunning
    }
    
    func successVibration() -> Void {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
    
    func warningVibration() -> Void {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.warning)
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
}
