import SwiftUI

struct TimerBox: View {
    
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    var body: some View {
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
        .overlay(Circle().stroke(Color.sprinBudCol, lineWidth: 2))
        .shadow(color: Color.sprinBudCol.opacity(0.7), radius: 7)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
}
