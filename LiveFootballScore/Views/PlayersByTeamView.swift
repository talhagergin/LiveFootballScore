import SwiftUI

struct PlayersByTeamView: View {
    let teamID: Int
    @State private var playersImages: [Int: String] = [:] // Her member.id için resim URL'si saklanır
    @State private var playerImageClient = PlayersImageClient()
    @State private var players: [ListPlayers] = []
    @State private var playersClient = PlayersByTeamClient()
    
    private func getPlayersByTeam(teamID: Int) async {
        do {
            players = try await playersClient.getPlayersByTeam(teamID: teamID)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    
    private func getPlayersImage(for memberID: Int) async {
        do {
            let image = try await playerImageClient.getPlayersImage(playerID: memberID)
            DispatchQueue.main.async {
                playersImages[memberID] = image
            }
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
         List {
             ForEach(players) { player in
                 Section(header: Text(player.title)) {
                     ForEach(player.members) { member in
                         NavigationLink(destination: PlayerDetailsView(playerID: member.id,playerName: member.name)) {
                             HStack {
                                 Text(member.name)
                                     .frame(maxWidth: .infinity, alignment: .leading)
                                 Spacer()
                                 AsyncImage(url: URL(string: playersImages[member.id] ?? "")) { image in
                                     image.resizable()
                                 } placeholder: {
                                     ProgressView()
                                 }
                                 .frame(width: 40, height: 40)
                                 .clipShape(Circle())
                                 .onAppear {
                                     if playersImages[member.id] == nil {
                                         Task {
                                             await getPlayersImage(for: member.id)
                                         }
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         }
         .navigationTitle("Kadro")
         .onAppear {
             Task {
                 await getPlayersByTeam(teamID: teamID)
             }
         }
     }
 }
