//
//  MainTabView.swift
//  GitHub Insights
//
//  Created by Brian Moyou on 09.09.24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tag(Tab.home)
                .tabItem { Image(systemName: "house") }
            
            ProfileView()
                .tag(Tab.profile)
                .tabItem { Image(systemName: "person") }
        }
    }
}

#Preview {
    MainTabView()
}
