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
        List {
            Section(header: HStack {
                Text("Takım").frame(maxWidth: .infinity, alignment: .leading)
                Text("P").frame(width: 50, alignment: .center)
                Text("G").frame(width: 70, alignment: .center)
                Text("M").frame(width: 70, alignment: .center)
                Text("B").frame(width: 70, alignment: .center)
//                Text("Logo").frame(width: 50, alignment: .center)
            }) {
                ForEach(teams) { team in
                    NavigationLink(destination: PlayersByTeamView(teamID: team.id)) {
                        HStack {
                            Text(team.name).frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(team.pts)").frame(width: 30, alignment: .center)
                            Text("\(team.wins)").frame(width: 30, alignment: .center)
                            Text("\(team.losses)").frame(width: 30, alignment: .center)
                            Text("\(team.draws)").frame(width: 30, alignment: .center)
                            AsyncImage(url: URL(string: team.logo)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .frame(width: 50, alignment: .center)
                        }
                    }
                }
            }
        }
        .navigationTitle("Ligler")
        .onAppear {
            Task {
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
