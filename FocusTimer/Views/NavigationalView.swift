//
//  NavigationalView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 28/07/25.
//

import SwiftUI

struct NavigationalView: View {
    
    private let sessionViewModel: SessionViewModel = SessionViewModel()
    @State private var sesseionWrapper: SessionWrapper?
    @State private var offsetValue: CGFloat = 0.0
    @State private var sessions: [Session]
    @ObservedObject var timerViewModel: TimerViewModel
    
    init(timerViewModel: TimerViewModel) {
//        self.sessionViewModel = SessionViewModel()
        self.timerViewModel = timerViewModel
        _sessions = State(wrappedValue: sessionViewModel.getSessions())
        print("sessionsIn Nav: \(_sessions)")
    }
    
    var body: some View {
        HStack {
            if sessions.isEmpty {
                NavigationLink(value: "Nothing is here!🙈") {
                    HStack(alignment: .center) {
                        Text("Go to Details")
                        Image(systemName: "empty")
                            .opacity(0.5)
                    }
                    .navigationDestination(for: String.self) { value in
                        Text(value)
                    }
                }
            } else {
                NavigationLink(value: SessionWrapper(sessions: sessions)) {
                    HStack(alignment: .center) {
                        Text("Go to Details")
                        Image(systemName: "chevron.right")
                            .offset(x: offsetValue)
                            .onAppear() {
                                withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                                    offsetValue = 4.5
                                }
                            }
                    }
                    .navigationDestination(for: SessionWrapper.self, destination: {value in
                        HistoryView(sessionsWrapper: value, timerViewModel: timerViewModel)
                    })
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
    }
}
