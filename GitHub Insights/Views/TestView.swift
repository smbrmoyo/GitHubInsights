//
//  TestView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 27.09.24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text("fff")
        detailView(option: 3)
    }
    
    @ViewBuilder
    func detailView(option: Int) -> some View {
        if option == 1 {
            Text("Option 1")
        } else if option == 2 {
            Text("2")
        }
    }
}

#Preview {
    TestView()
}
