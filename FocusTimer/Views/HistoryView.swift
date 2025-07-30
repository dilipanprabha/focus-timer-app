//
//  HistoryView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 28/07/25.
//

import SwiftUI

struct HistoryView: View {
    
    var sessionViewModel = SessionViewModel()
    @State private var showAlert = false
    @Binding var isDelete: Bool
    @Binding var sessions: [Session]
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        VStack {
            if isDelete {
                Text("Nothing is here!")
                    .onDisappear() {
                        isDelete = false
                    }
            } else {
                List {
                    ForEach(sessions) { session in
                        
                        if session.isFinished {
                            Text("✅ Focused \( timerViewModel.getTimeString( session.duration ) ) at \( session.completed.formatted(date: .omitted, time: .shortened) )")
                        } else {
                            Text("❌ Unfocused (\( timerViewModel.getTimeString( session.duration ) )) at \( session.completed.formatted(date: .omitted, time: .shortened) )")
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .toolbar {
                    EditButton() // Enables drag-to-move, edit UI
                }
                
                Button("Delete All") {
                    showAlert = true
                }
                .padding()
                .alert("Warning", isPresented: $showAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        sessions.removeAll()
                        sessionViewModel.loadSession()
                        sessionViewModel.deleteAll()
                        sessionViewModel.saveSession()
                        isDelete = true
                        print("Item deleted.")
                    }
                } message: {
                    Text("This will remove all your focus history. Are you sure you want to continue?")
                }
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        print("HistoryView(b): \(sessionViewModel.getSessions())")
        sessions.remove(atOffsets: offsets)
        sessionViewModel.setSessions(sessions)
        sessionViewModel.saveSession()
        isDelete = true
        print("HistoryView(a): \(sessionViewModel.getSessions())")
    }
}


