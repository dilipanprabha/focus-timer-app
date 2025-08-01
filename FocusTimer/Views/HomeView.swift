import SwiftUI

struct HomeView: View {
    
    @Binding var isStart: Bool
    @State private var fade = false
    @State private var greeting: String?
    @State private var sessions: [Session]
    @State private var hours: String = "00"
    @State private var minutes: String = "25"
    @State private var seconds: String = "00"
    @State private var activeField: HomeUserInputDisplayView.Field? = nil
    @AppStorage("goal") var goal: Int = 0
    @AppStorage("streak") var streak: Int = 0
    @ObservedObject var timerViewModel: TimerViewModel
    private let greetingViewModel = GreetingViewModel()
    private let sessionViewModel: SessionViewModel = SessionViewModel()
    
    init(isStart: Binding<Bool>, timerViewModel: TimerViewModel) {
        self._isStart = isStart
        self.timerViewModel = timerViewModel
        _sessions = State(wrappedValue: sessionViewModel.getSessions())
    }
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 16) {
                    
                    HomeHeaderView(streak: $streak, sessions: $sessions)
                    
                    HomeGreetingView(goal: $goal, fade: $fade, greeting: $greeting)
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.1) // 10% space from top
                    
                    HomeTimeInputView(isStart: $isStart, hours: $hours, minutes: $minutes, seconds: $seconds, sessions: $sessions, focusField: $activeField, timerViewModel: timerViewModel)

                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    activeField = nil
                }
                .onAppear {
                    cycleGreetingMessages()
                }
            }
        }
    }
    
    func cycleGreetingMessages() -> Void {
        fade = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            fade = false
            greeting = greetingViewModel.progressBasedGreet(goal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                fade = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            fade = false
            greeting = greetingViewModel.streakBasedGreet(streak)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                fade = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            let motivationalQuotes = [
                "🧠 Stay focused.",
                "🚶 One step at a time.",
                "💪 Deep work wins.",
                "📈 Discipline > Motivation.",
                "⏱️ Start now. Not later.",
                "🎯 Focus creates progress.",
                "🌱 Just 1% better today.",
                "🧘 Clear mind. Sharp focus.",
                "🎵 No rush. Just rhythm.",
                "✅ Progress, not perfection.",
                "🌬️ Breathe and begin.",
                "🔕 Silence fuels focus.",
                "🎯 One task. One win.",
                "⏳ Make minutes matter.",
                "🛠️ Create before you consume."
            ]
            let random: Int = Int.random(in: 0..<15)
            fade = false
            greeting = motivationalQuotes[random]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                fade = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            fade = false
            greeting = greetingViewModel.timeBasedGreet()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                fade = true
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
