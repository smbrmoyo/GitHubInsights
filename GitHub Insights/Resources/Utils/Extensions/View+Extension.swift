//
//  View+Extension.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

extension View {
    func toast(toast: Binding<Toast?>, topPadding: CGFloat = 0, onDismiss: @escaping () -> Void = {}) -> some View {
        self.modifier(ToastModifier(toast: toast, topPadding: topPadding, onDismiss: { onDismiss() }))
    }
    
    func elevation() -> some View {
        self
            .shadow(color: .darkShadow, radius: 4, x: 2, y: 2)
    }
}
