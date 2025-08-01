import SwiftUI

struct CountdownDisplayView: View {
    
    @Binding var isStart: Bool
    @ObservedObject var timerViewModel: TimerViewModel
    @AppStorage("isVibration") private var isVibration: Bool = true
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
       
        VStack {
            
            HStack(spacing: 2) {
                Image(systemName: "bell.fill")
                Text("Ends at \( timerViewModel.getCompletedTime().formatted(date: .omitted, time: .shortened) )")
            }
            .font(.footnote)
            .opacity(0.5)
            .foregroundColor(.secondary)
            .padding(.top, 20)

            
            Spacer()
            
            HStack(spacing: 3) {
                
                Text((timerViewModel.getHour() < 10 && timerViewModel.getHour() >= 0) ? "0\(timerViewModel.getHour())" : "\(timerViewModel.getHour())")
                    .foregroundStyle(timerViewModel.getCurrentSecond() <= 10 ? .red.opacity(0.6) : .primary)
                    .animation(nil)
                
                Text(" : ")
                    .font(.custom("xxlarge", size: 50))
                
                Text((timerViewModel.getMinute() < 10 && timerViewModel.getMinute() >= 0) ? "0\(timerViewModel.getMinute())" : "\(timerViewModel.getMinute())")
                    .animation(nil)
                    .padding(.vertical)
                    .foregroundStyle(timerViewModel.getCurrentSecond() <= 10 ? .red.opacity(0.6) : .primary)
                
                Text(" : ")
                    .font(.custom("xxlarge", size: 50))
                
                Text((timerViewModel.getSecond() < 10 && timerViewModel.getSecond() >= 00) ? "0\(timerViewModel.getSecond())" : "\(timerViewModel.getSecond())")
                    .animation(nil)
                    .foregroundStyle(timerViewModel.getCurrentSecond() <= 10 ? .red.opacity(0.6) : .primary)
                
            }
            
            Spacer()
            
            HStack {
                Text("\(timerViewModel.getPrecen())%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 20)
        }
        .font(.system(size: 36, weight: .bold, design: .monospaced))
        .padding()
        .foregroundStyle(.primary)
        .frame(width: 300, height: 300)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .shadow(color: Color.sprinBudCol.opacity(0.7), radius: 9)
        .overlay(
            Circle()
                .trim(from: 0, to: 1)
                .stroke(colorScheme == .dark ? Color.white.opacity(0.08) : Color.gray.opacity(0.15), style: StrokeStyle(lineWidth: 12, lineCap: .round))
        )
        .overlay(Circle()
            .trim(from: 0, to: timerViewModel.getProgress())
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [.purple, .purple]),
                    center: .center
                ),
                style: StrokeStyle(lineWidth: 14, lineCap: .round)
            )
            .rotationEffect(.degrees(-90))
            .shadow(color: Color.purple.opacity(0.5), radius: 10, x: 0, y: 0)
        )
        .shadow(color: Color.purple.opacity(0.5), radius: 10, x: 0, y: 0)
        .animation(.linear(duration: 1), value: timerViewModel.getProgress())
        .onReceive(timerViewModel.getTimerPublish()!, perform: {_ in
                if timerViewModel.isTimeZero() {
                    isStart = false
                    timerViewModel.timerCompleted()
                    if isVibration {
                        timerViewModel.successVibration()
                    }
                    return
                }
                
                timerViewModel.setHour(timerViewModel.currentHour())
                timerViewModel.setMinute(timerViewModel.currentMinute())
                timerViewModel.setSecond(timerViewModel.currentSecond())
            })
    }
}
