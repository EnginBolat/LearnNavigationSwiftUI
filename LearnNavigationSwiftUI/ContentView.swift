//
//  ContentView.swift
//  LearnNavigationSwiftUI
//
//  Created by Engin Bolat on 30.06.2025.
//

import SwiftUI

struct ContentView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destionation
                    .tag(screen as AppScreen)
                    .tabItem { screen.label }
            }
        }
    }
}
