//
//  Untitled.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 28/07/25.
//

import Foundation

class SessionViewModel: ObservableObject {
    private var sessions: [Session] = []
    
    func getSessions() -> [Session] {
        loadSession()
        return sessions
    }
    
    func setSessions(_ session: [Session]) -> Void {
        sessions = session
    }
    
    func addSession(_ id: UUID, _ duration: Int, _ date: Date, _ isCompleted: Bool) {
        let newSession = Session(id: id, duration: duration, completed: date, isFinished: isCompleted)
        sessions.append(newSession)
    }
    
    func updateSession(id: UUID, date: Date) -> Void {
        if sessions.isEmpty {
            return
        }
        
        if let index = sessions.firstIndex(where: { $0.id == id }) {
            sessions[index].completed = date
        }
    }
    
    func deleteSession(id: UUID) -> Void {
        if sessions.isEmpty {
            return
        }
        
        if let index = sessions.firstIndex(where: { $0.id == id }) {
            sessions.remove(at: index)
        }
    }
    
    func deleteAll() -> Void {
        sessions.removeAll()
    }

    func saveSession() -> Void {
        let encoder = JSONEncoder()
        
        let data = try? encoder.encode(sessions)
        
        UserDefaults.standard.set(data, forKey: "sessions")
        print("SessionViewModel: Session added")
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
}
