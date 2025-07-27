import SwiftUI
import Combine

struct ContentView: View {

    var body: some View {
        
        ZStack {
            Color.onyxCol
                .ignoresSafeArea()
            
            TimerView(hours: 00, minutes: 00, seconds: 10)
        }
    }
}


#Preview {
    ContentView()
}

