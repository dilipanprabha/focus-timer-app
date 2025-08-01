import Foundation

class GreetingViewModel {
    
    func timeBasedGreet() -> String {
        var greeting = ""
        
        let date     = Date()
        let calendar = Calendar.current
        let hour     = calendar.component(.hour, from: date)
//        let minutes  = calendar.component(.minute, from: date)
        let morning = 5; let afternoon=12; let evening=17; let night=21;
        if hour == morning || (hour > morning && hour < afternoon) {
            greeting = "☀️ Good Morning! Ready to focus?"
        } else if hour == afternoon || (hour > afternoon && hour < evening) {
            greeting = "🌤 Good Afternoon! Keep it going."
        } else if hour == evening || (hour > evening && hour < night) {
            greeting = "🌆 Good Evening! One more session?"
        } else if hour == night || hour > night || hour < morning {
            greeting = "🌙 Working late? Stay sharp."
        } 
        
        return greeting
    }
    
    func progressBasedGreet(_ goal: Int) -> String {
        var message = ""
        
        if goal == 0 {
            message = "Let’s begin your first session!"
        } else if goal == 2 {
            message = "You’re halfway there! Keep going 💪"
        } else if goal == 4 {
            message = "🎉 You crushed your daily goal!"
        } else if goal > 4 {
            message = "Take a short break ☕"
        }
        
        return message
    }

    func streakBasedGreet(_ streak: Int) -> String {
        var message = ""
        
        if streak == 0 {
            message = "New day, new chance to win 💡"
        } else if streak == 2 {
            message = "You’re building momentum. Keep going 💯"
        } else if streak == 3 {
            message = "Consistency is power. Keep it alive 🔥"
        } else if streak > 3 {
            message = "Keep showing up. Greatness builds daily 💼"
        }
        
        return message
    }
}
