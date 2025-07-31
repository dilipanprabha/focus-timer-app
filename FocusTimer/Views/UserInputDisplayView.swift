//
//  UserInputDisplayView.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 29/07/25.
//

import SwiftUI

struct UserInputDisplayView: View {
    
    enum Field: Hashable {
        case hours
        case minutes
        case seconds
    }
    
    @Binding var hours: String
    @Binding var minutes: String
    @Binding var seconds: String
    @State private var lastTypedTime: Date?
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
//        HStack(spacing: 65) {
//            Text("hr").font(.caption)
//            Text("min").font(.caption)
//            Text("sec").font(.caption)
//        }
        
        HStack(spacing: 8) {
            CustomTimeField(placeholder: "HH", isFocused: focusedField == .hours, value: $hours)
                .focused($focusedField, equals: .hours)
                .submitLabel(.next)
                .onChange(of: hours) { _, newValue in
                    hours = inputHandler(newValue)
                }
                .onSubmit {
                    focusedField = .minutes  // Jump to minutes field
                }
            Text(":").font(.title2)
            CustomTimeField(placeholder: "MM", isFocused: focusedField == .minutes, value: $minutes)
                .focused($focusedField, equals: .minutes)
                .submitLabel(.next)
                .onChange(of: minutes) { _, newValue in
                    minutes = inputHandler(newValue)
                }
                .onSubmit {
                    focusedField = .seconds  // Jump to seconds field
                }
            Text(":").font(.title2)
            CustomTimeField(placeholder: "SS", isFocused: focusedField == .seconds, value: $seconds)
                .focused($focusedField, equals: .seconds)
                .submitLabel(.go)
                .onChange(of: seconds) { _, newValue in
                    seconds = inputHandler(newValue)
                }
        }
    
//        Group {
//            HStack(spacing: 110) {
//                Text("hr")
//                Text("min")
//                Text("sec")
//            }
//            .foregroundStyle(.primary)
//            .font(.caption2)
//            .bold()
//            .frame(width: 350)
//            
//            HStack(alignment: .top) {
//                TextField("HH", text: $hours)
//                    .focused($focusedField, equals: .hours)
//                    .keyboardType(.numberPad)
//                    .submitLabel(.next)
//                    .onChange(of: hours) { _, newValue in
//                        hours = inputHandler(newValue)
//                    }
//                    .onSubmit {
//                        focusedField = .minutes  // Jump to minutes field
//                    }
//                Text(" : ")
//                    .font(.custom("xxlarge", size: 50))
//                TextField("00", text: $minutes)
//                    .focused($focusedField, equals: .minutes)
//                    .keyboardType(.numberPad)
//                    .submitLabel(.next)
//                    .onChange(of: minutes) { _, newValue in
//                        minutes = inputHandler(newValue)
//                    }
//                    .onSubmit {
//                        focusedField = .seconds  // Jump to seconds field
//                    }
//                Text(" : ")
//                    .font(.custom("xxlarge", size: 50))
//                TextField("00", text: $seconds)
//                    .focused($focusedField, equals: .seconds)
//                    .keyboardType(.numberPad)
//                    .submitLabel(.go)
//                    .onChange(of: seconds) { _, newValue in
//                        seconds = inputHandler(newValue)
//                    }
//            }
//            .font(.custom("xxlarge", size: 55))
//            .padding()
//            .foregroundStyle(.primary)
//            .frame(width: 350, height: 100)
//            .background(Color.cadGrey)
//            .clipShape(RoundedRectangle(cornerRadius: 9))
//            .shadow(color: Color.mint.opacity(0.9), radius: 9)
//            .padding(EdgeInsets(top: 8, leading: 0, bottom: 10, trailing: 0))
//        }
    }
    
    func inputHandler(_ newValue: String) -> String {
        let now = Date()
        defer { lastTypedTime = now }

        let digitsOnly = newValue.filter { $0.isNumber }
        guard !digitsOnly.isEmpty else {
            return ""
        }

        // Check time gap
        let gap = now.timeIntervalSince(lastTypedTime ?? .distantPast)

        if gap > 0.5 {
            // Slow typing — pad single digit
            if let intVal = Int(digitsOnly), intVal < 60 {
                return String(format: "%02d", intVal)
            } else {
                return ""
            }
        } else {
            // Fast typing — allow up to 2 digits
            let limited = String(digitsOnly.prefix(2))
            if let intVal = Int(limited), intVal < 60 {
                return limited
            } else if let lastChar = digitsOnly.last, let lastDigit = Int(String(lastChar)), lastDigit < 6 {
                return "0\(lastDigit)"
            } else {
                return ""
            }
        }
    }
}
