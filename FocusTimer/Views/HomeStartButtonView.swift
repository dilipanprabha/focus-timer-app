import SwiftUI

struct HomeStartButtonView: View {
    
    @State private var isPressed = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Start")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .padding(.vertical, 14)
                .padding(.horizontal, 60)
                .background(Color.sprinBudCol)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: Color.sprinBudCol.opacity(0.6), radius: 10, x: 0, y: 4)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .animation(.spring(), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}
