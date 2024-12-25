//
//  ContentView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var teamsClient = TeamsClient()
    @State private var teams: [Teams] = []

    var body: some View {
            NavigationView {
                LeaguesView()
            }
        }
    }
    


#Preview {
    ContentView()
}
