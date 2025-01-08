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
                // Haberler için tıklanabilir resim
                Section {
                    NavigationLink(destination: NewsView(selectionTabItem: .constant(1))) {
                        Image("badget")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .clipped()
                    }
                    .listRowInsets(EdgeInsets())
                }
                
                // Tablo Başlıkları
                Section(header: tableHeader) {
                    ForEach(teams) { team in
                        NavigationLink(destination: PlayersByTeamView(teamID: team.id)) {
                            tableRow(for: team)
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
                    TopPlayersView(leagueID: leagueID)
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
    
    // Tablo Başlıkları
   private var tableHeader: some View {
        HStack(spacing: 0) {
             HStack(spacing: 0) {
                   Text("Takım")
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.leading, 30) // Takım yazısının soluna boşluk ekledik
               }
            
            HStack(spacing: 0) {
                Text("P").frame(width: 25, alignment: .center)
                Text("G").frame(width: 25, alignment: .center)
                Text("M").frame(width: 25, alignment: .center)
                Text("B").frame(width: 25, alignment: .center)
                
            }
             Spacer()
            .frame(width: 50)

        }
        .padding(.horizontal, 10)

    }

    
    // Tablo Satırları
    private func tableRow(for team: Teams) -> some View {
        HStack(spacing: 0) {
          HStack(spacing: 0) {
                 Text("\(team.idx).")
                      .frame(width: 30,alignment: .leading)
                 Text(team.name)
                     .lineLimit(2)
                     .fixedSize(horizontal: false, vertical: true)
                      .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(spacing: 0) {
                Text("\(team.pts)").frame(width: 25, alignment: .center)
                Text("\(team.wins)").frame(width: 25, alignment: .center)
                Text("\(team.losses)").frame(width: 25, alignment: .center)
                Text("\(team.draws)").frame(width: 25, alignment: .center)
            }
            Spacer() // Logoyu sağa yaslamak için boşluk
            
            AsyncImage(url: URL(string: team.logo)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .frame(width: 50, alignment: .trailing)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    TeamsTableView(leagueID: 71)
}
