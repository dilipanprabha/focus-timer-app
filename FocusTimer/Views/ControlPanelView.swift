import SwiftUI

struct ControlPanelView: View {
    var title: String
    var color: Color
    var action: () -> Void
    
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
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
    }
}
