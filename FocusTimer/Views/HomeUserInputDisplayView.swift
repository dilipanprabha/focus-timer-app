import SwiftUI

struct HomeUserInputDisplayView: View {
    
    enum Field: Hashable {
        case hours
        case minutes
        case seconds
    }
    
    @Binding var hours: String
    @Binding var minutes: String
    @Binding var seconds: String
    @Binding var focusField: Field?
    @FocusState private var internalFocus: Field?
    
    var body: some View {
        
        HStack(spacing: 8) {
            CustomTimeField(placeholder: "HH", isFocused: internalFocus == .hours, value: $hours)
                .focused($internalFocus, equals: .hours)
                .submitLabel(.next)
                .onChange(of: hours) { _, newValue in
                    hours = inputHandler(newValue)
                }
                .onSubmit {
                    internalFocus = .minutes  // Jump to minutes field
                }
            
            Text(":").font(.title2)
            
            CustomTimeField(placeholder: "MM", isFocused: internalFocus == .minutes, value: $minutes)
                .focused($internalFocus, equals: .minutes)
                .submitLabel(.next)
                .onChange(of: minutes) { _, newValue in
                    minutes = inputHandler(newValue)
                }
                .onSubmit {
                    internalFocus = .seconds  // Jump to seconds field
                }
            
            Text(":").font(.title2)
            
            CustomTimeField(placeholder: "SS", isFocused: internalFocus == .seconds, value: $seconds)
                .focused($internalFocus, equals: .seconds)
                .submitLabel(.go)
                .onChange(of: seconds) { _, newValue in
                    seconds = inputHandler(newValue)
                }
        }
    }
    
    func inputHandler(_ newValue: String) -> String {
        let digits = newValue.filter { $0.isNumber }
        guard let intVal = Int(digits), intVal < 60 else {
            return ""
        }
        return String(format: "%02d", intVal)
    }
}
