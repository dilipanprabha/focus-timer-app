import SwiftUI

struct HistoryView: View {
    
    var sessionViewModel = SessionViewModel()
    @State private var animate: Bool = false
    @State private var showAlert = false
    @Binding var isDelete: Bool
    @Binding var sessions: [Session]
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        VStack {
            if isDelete {
                Text("Nothing is here!")
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
                    .onDisappear() {
                        isDelete = false
                    }
            } else {
                List {
                    ForEach(sessions.reversed()) { session in
                        
                        if session.isFinished {
                            Text("✅ Focused \( sessionViewModel.getTimeString( session.duration ) ) at \( session.completed.formatted(date: .omitted, time: .shortened) )")
                        } else {
                            Text("❌ Unfocused (\( sessionViewModel.getTimeString( session.duration ) )) at \( session.completed.formatted(date: .omitted, time: .shortened) )")
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
                        isDelete = true
                        sessions.removeAll()
                        sessionViewModel.deleteAll()
                        sessionViewModel.saveSession()
                    }
                } message: {
                    Text("This will remove all your focus history. Are you sure you want to continue?")
                }
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        sessions.remove(atOffsets: offsets)
        sessionViewModel.setSessions(sessions)
        sessionViewModel.saveSession()
        if sessions.isEmpty {
            isDelete = true
        }
    }
}


