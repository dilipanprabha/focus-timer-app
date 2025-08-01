import SwiftUI

struct SessionHistoryView: View {
    
    @State private var sessions: [Session]
    @State private var animate = false
    @State private var isEmpty: Bool = false
    private let sessionViewModel: SessionViewModel = SessionViewModel()
    
    init() {
        _sessions = State(wrappedValue: sessionViewModel.getSessions().filter{ $0.isFinished } )
    }
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Text("Your Focus Sessions")
                .font(.title)
                .bold()
            
            if sessions.isEmpty {
                Spacer()
                Text("Let’s build your focus habit.\nStart your first session now! 💪")
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .scaleEffect(animate ? 1 : 0.9)
                    .opacity(animate ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.6)) {
                            animate = true
                        }
                    }
                Spacer()
            } else {
                List {
                    ForEach(sessions, id: \.id) { session in
                        Text("✅ \( sessionViewModel.getTimeString( session.duration ) ) ") + Text("•").font(.system(size: 18, design: .monospaced)) +
                        Text(" \( dateFormat( session.completed ) )")
                    }
                }
                .font(.system(size: 18, design: .monospaced ))
                .padding(.vertical)
            }
            
        }
        .padding(.vertical)
    }
    
    func dateFormat(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let formatted = formatter.string(from: date)
        return formatted
    }
}

