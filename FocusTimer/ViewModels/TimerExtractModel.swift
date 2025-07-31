//
//  TimerExtract.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 26/07/25.
//

import Foundation

class TimerExtract {
    private var hours: Int
    private var minutes: Int 
    private var seconds: Int

    init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = (hours * 60 * 60) + (minutes * 60) + seconds
        self.minutes = (minutes * 60) + seconds
        self.seconds = seconds
    }

    func secLimit(count: Int) -> Int {
//        print("\(hours)H : \(minutes)m : \(seconds)s")
        if (seconds == 0 && minutes == 0 && hours == 0) {
            return 0
        }
        
        if seconds == 0 {
            seconds = 59
            return seconds
        }
        
        seconds -= count
        
        return seconds
    }

    func minLimit(count: Int) -> Int {
        
        if minutes == 0 {
            return 0
        }
        
        minutes -= count
        
        return minutes / 60
    }

    func houLimit(count: Int) -> Int {
        
        if (hours == 0) {
            return 0
        }
        
        hours -= count
        
        return hours / 3600
    }
    
    func makeTimerZero() -> Void {
        hours = 0
        minutes = 0
        seconds = 0
//        print("MakeTimeZero in TimeExtract called")
//        print("h: \(hours); m: \(minutes); s: \(seconds)")
    }
    
    func getCurrentSecond() -> Int {
        return hours
    }
    
    func completedAt(_ date: Date, _ totalSeconds: Int) -> Date {
        let calendar = Calendar.current
        let expectedDate = calendar.date(byAdding: .second, value: totalSeconds, to: date)
        return expectedDate!
    }
}
