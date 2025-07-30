import SwiftUI
import UIKit

struct ClockStyleTextField: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect

        // Select all when focus begins
        textField.addTarget(context.coordinator, action: #selector(Coordinator.didBeginEditing(_:)), for: .editingDidBegin)

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        // Select all when field is tapped
        @objc func didBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                textField.selectAll(nil)
            }
        }

        // Handle numeric validation only (no formatting)
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {

            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            let isNumeric = string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil || string.isEmpty
            let isWithinRange = (Int(updatedText) ?? 0) <= 59
            let isLengthOK = updatedText.count <= 2

            if isNumeric && isWithinRange && isLengthOK {
                text = updatedText
                return true
            }

            return false
        }
    }
}
