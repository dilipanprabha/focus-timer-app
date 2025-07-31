//
//  CustomTimeField.swift
//  FocusTimer
//
//  Created by Dilipan Prabha on 31/07/25.
//

import SwiftUI

struct CustomTimeField: View {
    
    var placeholder: String
    var isFocused: Bool
    @Binding var value: String

    var body: some View {
        TextField(placeholder, text: $value)
            .keyboardType(.numberPad)
            .font(.system(size: 28, design: .monospaced))
            .frame(width: 60, height: 55)
            .multilineTextAlignment(.center)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.cyan : .clear, lineWidth: 2)
                    .shadow(color: isFocused ? Color.cyan.opacity(0.6) : .clear, radius: 6)
            )
    }
}
