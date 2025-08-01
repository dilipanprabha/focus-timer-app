import SwiftUI

struct OnboardView: View {
    
    @State private var isFirstPage = true
    @State private var isSecondPage = false
    @State private var isThirdPage = false
    
    var body: some View {
        
        if isFirstPage {
            WelcomeView(isFirstPage: $isFirstPage, isSecondPage: $isSecondPage)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        } else if isSecondPage {
            SetGoalPageView(isSecondPage: $isSecondPage, isThirdPage: $isThirdPage)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        } else if isThirdPage {
            GetStartedPageView(isThirdPage: $isThirdPage)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        } else {
            ContentView()
        }
    }
    
}

#Preview {
    OnboardView()
}
