import SwiftUI

struct ControlPanel: View {
    var title: String
    var color: Color
    var action: () -> Void
    
    init(title: String, color: Color, action: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.action = action
        print("ControlPanel initialized")
    }
    
    var body: some View {
        Button(title, action: action)
            .padding()
            .frame(width: 300)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.primary)
            .font(.title2)
            .kerning(5)
            .textCase(.uppercase)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
    }
}

