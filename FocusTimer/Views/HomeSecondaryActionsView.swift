import SwiftUI

struct HomeSecondaryActionsView: View {
    
    @Binding var sessions: [Session]
    @State private var isDelete: Bool = false
    @State private var animate: Bool = false
    @State private var offsetValue: CGFloat = 0.0
    @ObservedObject var timerViewModel: TimerViewModel

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
