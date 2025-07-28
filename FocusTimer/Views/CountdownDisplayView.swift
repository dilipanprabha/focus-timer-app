import SwiftUI
import Combine

struct CountdownDisplayView: View {
    
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStackLayout(alignment: .center) {
            Text("\(timerViewModel.getPrecen(progress: timerViewModel.getProgress()))%")
                .font(.caption)
        }
        HStack(alignment: .bottom) {
            VStack {
                Text("hr")
                    .font(.caption2)
                Text((hours < 10 && hours >= 0) ? "0\(hours)" : "\(hours)")
            }
            Text(" : ")
                .font(.custom("xxlarge", size: 50))
            VStack {
                Text("min")
                    .font(.caption2)
                Text((minutes < 10 && minutes >= 0) ? "0\(minutes)" : "\(minutes)")
            }
            Text(" : ")
                .font(.custom("xxlarge", size: 50))
            VStack {
                Text("sec")
                    .font(.caption2)
                Text((seconds < 10 && seconds >= 00) ? "0\(seconds)" : "\(seconds)")
            }
        }
        .font(.custom("xxlarge", size: 45))
        .padding()
        .foregroundStyle(.primary)
        .frame(width: 300, height: 300)
        .background(Color.cadGrey)
        .clipShape(Circle())
        .shadow(color: Color.sprinBudCol.opacity(0.7), radius: 9)
        .overlay(Circle().trim(from: 0, to: timerViewModel.getProgress()).stroke(Color.sprinBudCol, style: StrokeStyle(lineWidth: 12, lineCap: .round)).rotationEffect(.degrees(-90)))
        .animation(.linear(duration: 0), value: timerViewModel.getProgress())
        .onReceive(timerViewModel.getTimerPublish()!, perform: {_ in
                print("onReceive triggered")
                if timerViewModel.isTimeZero() {
                    timerViewModel.timerReset()
                    return
                }
                
                hours = timerViewModel.currentHour()
                minutes = timerViewModel.currentMinute()
                seconds = timerViewModel.currentSecond()
            })
    }
}
