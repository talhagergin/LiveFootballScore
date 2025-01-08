import SwiftUI

struct PlayerDetailsView: View {
    let playerID: Int
    let playerName: String?
    @State private var playersImages: [Int: String] = [:]
    @State private var playerImageClient = PlayersImageClient()
    @State private var playerDetails: [Detail] = []
    @State private var playerDetailsClient = PlayerDetailsClient()
    @State private var marketValue: String?
    //@State private var playerName: String?


    private func getPlayerDetailsByTeam(playerID: Int) async {
        do {
            playerDetails = try await playerDetailsClient.getPlayerDetailsByPlayerID(playerID: playerID)
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

    private func detailText(for detail: Detail) -> String {
        if let fallback = detail.value.fallback {
            switch fallback {
            case .string(let text):
                return text
            case .number(let number):
                return String(number)
            }
        } else if let numberValue = detail.value.numberValue {
            return String(numberValue)
        } else if let key = detail.value.key {
            return key
        } else {
            return ""
        }
    }

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    // Header with Image, Player Name, and Market Value
                    HStack(spacing: 10) { // spacing değeri eklendi
                        if let imageURL = playersImages[playerID] {
                            AsyncImage(url: URL(string: imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                                    .shadow(radius: 3)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                                    .background(Color.gray.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        
                        VStack(alignment: .center, spacing: 5) {
                            HStack{
                                if let playerName = playerName {
                                    Text(playerName)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                                if let marketValue = marketValue {
                                    Text("(\(marketValue))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                            }
                        }
                         Spacer()
                        
                    }
                     .padding(.horizontal)
                     .padding(.top,20)
                    
                    Divider()
                        .padding(.vertical,10)
                    
                    // Player Details List
                    VStack(alignment: .center,spacing: 10) {
                         ForEach(playerDetails) { detail in
                            if detail.translationKey != "market_value" && detail.translationKey != "player_name" {
                                VStack(alignment: .center) {
                                        Text(detail.title)
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                        
                                     Text(detailText(for: detail))
                                           .padding(.vertical, 4)
                                           .frame(maxWidth: .infinity, alignment: .center)
                                        Divider()
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .navigationTitle("Oyuncu Detayları")
                .onAppear {
                    Task {
                        await getPlayerDetailsByTeam(playerID: playerID)
                        await getPlayersImage(for: playerID)
                    }
                }
            }
        }
    }

    #Preview {
        PlayerDetailsView(playerID: 671529,playerName: "mehmet")
    }
