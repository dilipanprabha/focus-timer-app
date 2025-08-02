import Foundation
import SwiftUI

class GoalManager {
    
    private var goal: Int = 0
    private var streak: Int = 0
    private var date: [Date] = []
    private var isGoalReached: Bool = false
    private var dailyFocusGoal: Int = 4
    private var selectedSession: Int = 25
        
    func delAll() -> Void {
        date.removeAll()
        saveDate()
        
        goal = 0
        saveGoal()
        
        streak = 0
        saveStreak()
        
        isGoalReached = false
        saveIsGoalReached()
    }
    
    func goalAdd(_ totalSeconds: Int) -> Void {
        loadSelectedSession()
        if totalSeconds < (selectedSession * 60) {
            return
        }
        
        if totalSeconds >= (selectedSession * 60) {
            loadGoal()
            goal += 1
            saveGoal()
        }
    }

    func isReached() -> Void {
        loadIsGoalReached()
        loadDailyFocusGoal()
        
        if isGoalReached {
            return
        }
        
        if goal < dailyFocusGoal {
            return
        }
        
        isGoalReached = true
        
        loadDate()
        
        if let lastElement = date.last {
            streakCount(lastElement)
        } else {
            loadStreak()
            streak = 1
            saveStreak()
        }
        
        date.append(Date())
        saveDate()
        
        saveIsGoalReached()
    }
    
    func streakCount(_ yesterday: Date) -> Void {

        let calendar = Calendar.current
        let isYesterday = calendar.isDateInYesterday(yesterday)
        
        if !isYesterday {
            loadStreak()
            streak = 1
            saveStreak()
            
            return
        }
        loadStreak()
        streak += 1
        saveStreak()
    }
    
    func saveSelectedSession() -> Void {
        UserDefaults.standard.set(isGoalReached, forKey: "selectedSession")
    }
    
    func loadSelectedSession() -> Void {
        selectedSession = (Int(UserDefaults.standard.string(forKey: "selectedSession") ?? "\(selectedSession)") ?? selectedSession)
    }
    
    func saveDailyFocusGoal() -> Void {
        UserDefaults.standard.set(isGoalReached, forKey: "dailyFocusGoal")
    }
    
    func loadDailyFocusGoal() -> Void {
        dailyFocusGoal = UserDefaults.standard.integer(forKey: "dailyFocusGoal")
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
