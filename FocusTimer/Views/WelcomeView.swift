import SwiftUI

struct WelcomeView: View {
    
    @Binding var isFirstPage: Bool
    @Binding var isSecondPage: Bool
    @State private var animate: CGFloat = 0.0
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image("WelcomeIllustration")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            Text("Welcome to Focus Timer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Stay focused, build better habits, and take control of your time.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4), {
                    isFirstPage = false
                    isSecondPage = true
                })
            }) {
                HStack(spacing: 3) {
                    Text("Next")
                    Text("→")
                        .offset(x: animate)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .onAppear() {
            withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: true), {
                animate = 2.5
            })
        }
    }
    
}
