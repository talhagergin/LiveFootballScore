//
//  LeagueDetailsView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct TeamsTableView: View {
    let leagueID: Int
    @State private var teamsClient = TeamsClient()
    @State private var teams: [Teams] = []
    @State private var showMatches = false
    @State private var showTopPlayers = false
    
    private func getTeamsByLeagueID(leagueID: Int) async {
        do {
            teams = try await teamsClient.getTeamsByLeagueID(leagueID: leagueID)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ZStack {
            List {
                Section(header: HStack {
                    Text("Takım").frame(maxWidth: .infinity, alignment: .leading)
                    Text("P").frame(width: 50, alignment: .center)
                    Text("G").frame(width: 70, alignment: .center)
                    Text("M").frame(width: 70, alignment: .center)
                    Text("B").frame(width: 70, alignment: .center)
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
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showMatches.toggle()
                    } label: {
                        Text("Fikstür")
                    }
                    
                    Button {
                        showTopPlayers.toggle()
                    } label: {
                        Text("İstatistik Liderleri")
                    }
                    
                }
            }
            .sheet(isPresented: $showMatches) {
                NavigationView {
                    MatchesView(leagueID: leagueID)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Kapat") {
                                    showMatches = false
                                }
                            }
                        }
                }
            }
            .sheet(isPresented: $showTopPlayers) {
                 NavigationView {
                    TopPlayersView(leagueID: leagueID) // leagueID'yi TopPlayersView'e aktarıyoruz
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Kapat") {
                                    showTopPlayers = false
                                }
                            }
                        }
                }
            }
        }
        .onAppear {
            Task {
                await getTeamsByLeagueID(leagueID: leagueID)
            }
        }
    }
}

#Preview {
    TeamsTableView(leagueID: 71)
}
