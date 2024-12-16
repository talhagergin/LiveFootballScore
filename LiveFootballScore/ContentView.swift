//
//  ContentView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var leaguesClient = LeaguesClient()
    @State private var countries: [CountryLeagues] = []
    @State private var teamsClient = TeamsClient()
    @State private var teams: [Teams] = []
        private func getLeaguesByCountry() async {
            do {
                countries = try await leaguesClient.getLeaguesByCountry()
            } catch {
                print("Hata oluştu: \(error.localizedDescription)")
            }
        }
    private func getTeamsByLeagueID(leagueID: Int) async {
        do {
            teams = try await teamsClient.getTeamsByLeagueID(leagueID: leagueID)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }

    var body: some View {
            NavigationView {
                LeaguesView(countries: countries)
                .onAppear {
                    Task {
                        print("closed")
                        
                        //await getLeaguesByCountry()
                        //await getTeamsByLeagueID(leagueID: 71)
                    }
                }
            }
        }
    }
    


#Preview {
    ContentView()
}
