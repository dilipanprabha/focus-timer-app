import SwiftUI

struct GetStartedPageView: View {
    
    @Binding var isThirdPage: Bool
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image("SuccessIllutration")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            Text("Stay Focused & Achieve More")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Focus Timer helps you build habits, avoid distractions, and track your progress—all in one place.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Let’s Get Started 🚀") {
                hasSeenOnboarding = true
                withAnimation(.easeInOut(duration: 0.4), {
                    isThirdPage = false
                })
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
}
