import SwiftUI

struct SetGoalPageView: View {
    
    @Binding var isSecondPage: Bool
    @Binding var isThirdPage: Bool
    @State private var animate: CGFloat = 0.0
    @AppStorage("dailyFocusGoal") var dailyFocusGoal: Int = 4
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image("GoalIllustration")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            Text("Set Your Daily Goal")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text("How many focus sessions do you want to complete each day?")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                ForEach([2, 3, 4, 5], id: \.self) { goal in
                    Text("\(goal)")
                        .frame(width: 44, height: 44)
                        .background(true ? Color.accentColor : Color.gray.opacity(0.2))
                        .overlay(dailyFocusGoal == goal ? Circle().stroke(Color.primary, lineWidth: 5) : Circle().stroke(Color.primary, lineWidth: 0))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .onTapGesture {
                            dailyFocusGoal = goal
                        }
                }
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4), {
                    isSecondPage = false
                    isThirdPage = true
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
            withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: true) , {
                animate = 2.5
            })
        }
    }
    
}
