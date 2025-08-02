import SwiftUI

struct HomeHeaderView: View {
    
    @Binding var streak: Int
    @Binding var sessions: [Session]
    @Binding var minutes: String
    @State private var showSheet = false
    @AppStorage("appearance") private var appearance: String = "system"
    
    var body: some View {
        
        Text("Focus Timer")
            .font(.title)
            .bold()
            .padding(.bottom)
        
        HStack {
            Button(action: {
                showSheet = true
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "gear")
                        .font(.system(size: 24))
                        .foregroundColor(.primary)

                    Text("Settings")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            .sheet(isPresented: $showSheet) {
                
                SettingsView(sessions: $sessions, minutes: $minutes, onDismiss: {
                    showSheet = false
                })
                    .id(appearance)
                
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .foregroundStyle(.orange)
                    .font(.system(size: 24))
                Text("Streak: \(streak)")
                    .font(.system(size: 20))
            }
        }
        .padding(.horizontal)
        
    }
}
