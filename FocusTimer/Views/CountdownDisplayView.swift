import SwiftUI

struct CountdownDisplayView: View {
    
//    @Binding var hours: Int
//    @Binding var minutes: Int
//    @Binding var seconds: Int
    @Binding var isStart: Bool
    @ObservedObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                Text("hr")
                    .font(.caption2)
//                Text((hours < 10 && hours >= 0) ? "0\(hours)" : "\(hours)")
                Text((timerViewModel.getHour() < 10 && timerViewModel.getHour() >= 0) ? "0\(timerViewModel.getHour())" : "\(timerViewModel.getHour())")
            }
            Text(" : ")
                .font(.custom("xxlarge", size: 50))
            VStack {
                Text("\(timerViewModel.getPrecen())%")
                    .font(.caption).padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text("min")
                    .font(.caption2)
//                Text((minutes < 10 && minutes >= 0) ? "0\(minutes)" : "\(minutes)")
                Text((timerViewModel.getMinute() < 10 && timerViewModel.getMinute() >= 0) ? "0\(timerViewModel.getMinute())" : "\(timerViewModel.getMinute())")
            }
            Text(" : ")
                .font(.custom("xxlarge", size: 50))
            VStack {
                Text("sec")
                    .font(.caption2)
//                Text((seconds < 10 && seconds >= 00) ? "0\(seconds)" : "\(seconds)")
                Text((timerViewModel.getSecond() < 10 && timerViewModel.getSecond() >= 00) ? "0\(timerViewModel.getSecond())" : "\(timerViewModel.getSecond())")
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
                    isStart = false
                    timerViewModel.timerCompleted()
//                    timerViewModel.timerReset()
                    timerViewModel.successVibration()
                    return
                }
                
//                hours = timerViewModel.currentHour()
                timerViewModel.setHour(timerViewModel.currentHour())
//    //                minutes = timerViewModel.currentMinute()
                timerViewModel.setMinute(timerViewModel.currentMinute())
//    //                seconds = timerViewModel.currentSecond()
                timerViewModel.setSecond(timerViewModel.currentSecond())
            })
    }
}
