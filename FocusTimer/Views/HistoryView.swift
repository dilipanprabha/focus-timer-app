//
//  HistoryView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 28/07/25.
//

import SwiftUI

struct HistoryView: View {
    
    var sessionsWrapper: SessionWrapper
    @State private var showAlert = false
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(sessionsWrapper.sessions) { session in
                    
                    if session.isFinished {
                        Text("✅ Focused \( timerViewModel.getTimeString( session.duration ) ) at \( session.completed.formatted(date: .omitted, time: .shortened) )")
                    } else {
                        Text("❌ Unfocused (\( timerViewModel.getTimeString( session.duration ) )) at \( session.completed.formatted(date: .omitted, time: .shortened) )")
                    }
                }
            }
            Button("Delete All") {
                showAlert = true
            }
            .padding()
            .alert("Warning", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    timerViewModel.deleteAllSession()
                    print("Item deleted.")
                }
            } message: {
//                Text("Are you sure you want to delete all items?")
                Text("This will remove all your focus history. Are you sure you want to continue")
            }
        }
    }
}


