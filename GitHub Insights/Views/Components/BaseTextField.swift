//
//  BaseTextField.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct TextFieldHint: View {
    let hint: String
    var body: some View {
        return Text(hint)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.red)
            .frame(height: hint.isEmpty ? 1 : 29)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TextFieldName: View {
    let name: String
    var body: some View {
        return Text(name)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .padding(.horizontal, 8)
            .bold()
    }
}

struct BaseTextField : View {
    var placeholder: String
    var length: Int
    var type: String = ""
    var keyboardType: UIKeyboardType
    var autoCap: Bool = false
    var padding: CGFloat = 4
    @State var isSecure: Bool
    @State var textFieldName: String
    @State var invalidTextHint: String
    @State var regexes: [Regex]
    @State private var isFocused: Bool = false
    @State var hint: String = ""
    @Binding var text: String {
        didSet {
            guard regexes.isEmpty == false else {
                isValidText = true
                return
            }
            isValidText = text.isValid(regexes: regexes.compactMap { "\($0.rawValue)" })
        }
    }
    
    @Binding var isValidText: Bool {
        didSet {
            hint = isValidText ? "" : invalidTextHint
        }
        
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            TextFieldName(name: textFieldName)
            
            TextField(UUID().uuidString, text: $text, prompt: Text(placeholder), axis: .vertical)
                .onChange(of: text) { _, newValue in
                    self.text = String(newValue.prefix(length))
                }
                .lineLimit(3)
                .keyboardType(keyboardType)
                .fontWeight(.regular)
                .padding(.vertical, 12)
                .padding(.horizontal, 8)
                .textInputAutocapitalization(autoCap ? .words : .never)
                .multilineTextAlignment(.leading)
                .background(Color.white)
                .cornerRadius(10)
                .font(.system(size: 17, weight: .thin))
                .disableAutocorrection(true)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
            
            if !isValidText {
                TextFieldHint(hint: hint)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, padding)
    }
}
