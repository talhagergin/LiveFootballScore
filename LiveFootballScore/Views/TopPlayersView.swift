import SwiftUI

struct TopPlayersView: View {
    let leagueID: Int
    @State private var playersClient = PlayersClient()
    @State private var playersGol: [Player] = []
    @State private var playersAssist: [PlayerAssist] = []
    @State private var playersRating: [PlayerRating] = []
    
    private func getPlayers(leagueId: Int) async {
        do {
            playersGol = try await playersClient.getPlayersByLeagueID(leagueID: leagueId)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    private func getPlayersAssist(leagueId: Int) async {
        do {
            playersAssist = try await playersClient.getAssistPlayersByLeagueID(leagueID: leagueId)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    private func getPlayersRating(leagueId: Int) async {
           do {
               playersRating = try await playersClient.getRatingPlayersByLeagueID(leagueID: leagueId)
           } catch {
               print("Hata oluştu: \(error.localizedDescription)")
           }
       }
    var body: some View {
        ZStack {
            List {
                TopPlayersComponent(items: playersRating, title: "👑 Rating Krallığı")
                
                TopPlayersComponent(items: playersGol, title: "🏆 Gol Krallığı")
                
                TopPlayersComponent(items: playersAssist, title: "⚽️ Assist Krallığı")
            }
            .navigationTitle("İstatistik Liderleri")
        }.onAppear {
            Task {
                await getPlayers(leagueId: leagueID)
                await getPlayersAssist(leagueId: leagueID)
                 await getPlayersRating(leagueId: leagueID)
            }
        }
    }
}
#Preview {
    TopPlayersView(leagueID: 71)
}
