import SwiftUI
import Combine

struct ContentView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Color.onyxCol
                    .ignoresSafeArea()
                
                TimerView()
            }
        }
    }
}


#Preview {
    ContentView()
}

