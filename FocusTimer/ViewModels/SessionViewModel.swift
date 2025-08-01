import Foundation

class SessionViewModel: ObservableObject {
    @Published private var sessions: [Session] = []
    
    func getSessions() -> [Session] {
        loadSession()
        return sessions
    }
    
    func setSessions(_ session: [Session]) -> Void {
        sessions = session
    }
    
    func addSession(_ duration: Int, _ date: Date, _ isCompleted: Bool) {
        let newSession = Session(id: UUID(), duration: duration, completed: date, isFinished: isCompleted)
        sessions.append(newSession)
    }
    
    func deleteAll() -> Void {

        sessions.removeAll()

    }

    func saveSession() -> Void {
        let encoder = JSONEncoder()
        
        let data = try? encoder.encode(sessions)
        
        UserDefaults.standard.set(data, forKey: "sessions")
    }
    
    func loadSession() -> Void {
        let decoder = JSONDecoder()
        
        let data = UserDefaults.standard.data(forKey: "sessions") ?? Data()
        
        if !data.isEmpty {
            do {
                sessions = try decoder.decode([Session].self, from: data)
            } catch {
                print("❌ Failed to decode \(error)")
            }
            return
        }
        sessions = []
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
