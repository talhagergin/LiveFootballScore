//
//  ContentView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectionItem = 0
    var body: some View {
        TabView(selection: $selectionItem) {
            NavigationView {
                LeaguesView(selectionTabItem: $selectionItem)
            }
            .tabItem {
                Label("Ligler", systemImage: "sportscourt")
                    .environment(\.symbolVariants, selectionItem == 0 ? .fill : .none)
            }
            .tag(0)

            NavigationView {
                NewsView(selectionTabItem: $selectionItem)
            }
            .tabItem {
                Label("Haberler", systemImage: "newspaper")
                    .environment(\.symbolVariants, selectionItem == 1 ? .fill : .none)
            }
            .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
    
