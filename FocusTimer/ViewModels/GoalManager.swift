//
//  GoalManager.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 31/07/25.
//

import Foundation
import SwiftUI

class GoalManager {
    
    private var goal: Int = 0
    private var streak: Int = 0
    private var date: [Date] = []
    private var isGoalReached: Bool = false
    @AppStorage("dailyFocusGoal") private var dailyFocusGoal: Int = 4
    
    
    
//    func delAll() -> Void {
//        loadDate()
//        date.removeAll()
////        date.append(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
//        saveDate()
//        loadGoal()
//        goal = 0
//        saveGoal()
//        loadStreak()
//        streak = 0
//        saveStreak()
//        loadIsGoalReached()
//        isGoalReached = false
//        saveIsGoalReached()
//    }
    
    
//    func getGoal() -> Int {
//        return goal
//    }
//    
//    func getStreak() -> Int {
//        return streak
//    }
    
    func goalAdd(_ totalSeconds: Int) -> Void {
        if totalSeconds < 600 {
            return
        }
        
        if totalSeconds >= 600 {
//            print("GoalManager (goalAdd()): goal-\(goal)")
            goal += 1
        }
    }

    func isReached() -> Void {
        loadIsGoalReached()
        
        if isGoalReached {
//            print("GoalManager (isReached()): goal is already reached")
            return
        }
        
        if goal < dailyFocusGoal {
//            print("GoalManager (isReached()): less than 4 [goal-\(goal)]")
            return
        }
        
//        print("(isReached()) : now goal is 4")
        isGoalReached = true
        
        loadDate()
        
//        print("GoalManager(before load) (isReached()): date-\(date)")
        if let lastElement = date.last {
            streakCount(lastElement)
        } else {
            loadStreak()
//            print("GoalManager(before load) (isReached()): streak-\(streak)")
            streak = 1
//            print("GoalManager(after load) (isReached()): streak-\(streak)")
            saveStreak()
        }
        
        date.append(Date())
//        print("GoalManager(after load) (isReached()): date-\(date)")
        saveDate()
        
        saveIsGoalReached()
    }
    
    func streakCount(_ yesterday: Date) -> Void {

        let calendar = Calendar.current
        let isYesterday = calendar.isDateInYesterday(yesterday)
        
        if !isYesterday {
//            print("GoalManager (streakCount()): you missed yesterday")
            loadStreak()
//            print("GoalManager(before load) (streakCount()): streak-\(streak)")
            streak = 1
//            print("GoalManager(after load)  (streakCount()): streak-\(streak)")
            saveStreak()
            
            return
        }
//        print("GoalManager (streakCount()): you did yesterday")
        loadStreak()
//        print("GoalManager(before load) (streakCount()): streak-\(streak)")
        streak += 1
//        print("GoalManager(after load) (streakCount()): streak-\(streak)")
        saveStreak()
    }
    
    
    func saveIsGoalReached() -> Void {
        UserDefaults.standard.set(isGoalReached, forKey: "isGoalReached")
    }
    
    func loadIsGoalReached() -> Void {
        isGoalReached = UserDefaults.standard.bool(forKey: "isGoalReached")
    }
    
    func saveGoal() -> Void {
        UserDefaults.standard.set(goal, forKey: "goal")
    }
    
    func loadGoal() -> Void {
        goal = UserDefaults.standard.integer(forKey: "goal")
    }
    
    func saveStreak() -> Void {
        UserDefaults.standard.set(streak, forKey: "streak")
    }
    
    func loadStreak() -> Void {
        streak = UserDefaults.standard.integer(forKey: "streak")
    }
    
    func saveDate() -> Void {
        let encoder = JSONEncoder()
        
        let data = try? encoder.encode(date)
        
        UserDefaults.standard.set(data, forKey: "date")
        print("GoalManager: Date added")
    }
    
    func loadDate() -> Void {
        let decoder = JSONDecoder()
        
        let data = UserDefaults.standard.data(forKey: "date") ?? Data()
        
        if !data.isEmpty {
            do {
                date = try decoder.decode([Date].self, from: data)
            } catch {
                print("❌ Failed to decode \(error)")
            }
            return
        }
        date = []
    }
}
