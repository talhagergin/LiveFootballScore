//
//  LeagueDetailsView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct TeamsTableView: View {
    //let teams :[Teams]
    let leagueID: Int
    @State private var teamsClient = TeamsClient()
    @State private var teams: [Teams] = []
    private func getTeamsByLeagueID(leagueID: Int) async {
        do {
            teams = try await teamsClient.getTeamsByLeagueID(leagueID: leagueID)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    var body: some View {
        List(teams) { team in
            NavigationLink(destination: PlayersByTeamView(teamID: team.id)){
                HStack {
                    Text(team.name)
                    Spacer()
                    AsyncImage(url: URL(string: team.logo)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            }
                   
        }
        .navigationTitle("Ligler")
        .onAppear{
            Task{
                await getTeamsByLeagueID(leagueID: leagueID)
            }
            
        }
    }
}
/*
#Preview {
    TeamsTableView()
}
*/
