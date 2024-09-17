//
//  ViewOffsetKey.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 17.09.24.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
