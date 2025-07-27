import SwiftUI
import Combine

struct ContentView: View {

    var body: some View {
        
        ZStack {
            Color.onyxCol
                .ignoresSafeArea()
            
            TimerView(hours: 00, minutes: 25, seconds: 0)
        }
    }
}


#Preview {
    ContentView()
}

