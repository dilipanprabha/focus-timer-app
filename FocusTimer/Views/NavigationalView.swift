//
//  NavigationalView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 28/07/25.
//

import SwiftUI

struct NavigationalView: View {
    
    private let sessionViewModel: SessionViewModel = SessionViewModel()
    @State private var isDelete: Bool = false
    @State private var offsetValue: CGFloat = 0.0
    @State private var sessions: [Session]
//    @Binding var isClicked: Bool
    @ObservedObject var timerViewModel: TimerViewModel
    
    init(timerViewModel: TimerViewModel) {
        
        self.timerViewModel = timerViewModel
        _sessions = State(wrappedValue: sessionViewModel.getSessions())
        print("sessionsIn Nav: \(_sessions)")
    }
    
    var body: some View {
        HStack {
            if sessions.isEmpty && !isDelete {
                NavigationLink(value: "Nothing is here!🙈") {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.arrow.circlepath") // or "list.bullet"
                        Text("View Session History")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .underline()
                    .navigationDestination(for: String.self) { value in
                        Text(value)
                    }
                }
            } else {
                NavigationLink(value: "") {
                    HStack(alignment: .center, spacing: 4) {
                        Text("View Session History")
                        Image(systemName: "chevron.right")
                            .offset(x: offsetValue)
                            .onAppear() {
                                withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                                    offsetValue = 4.5
                                }
                            }
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .underline()
                    .navigationDestination(for: String.self, destination: {_ in
                        HistoryView(isDelete: $isDelete, sessions: $sessions, timerViewModel: timerViewModel)
                    })
                }
            }
        }
    }
}
