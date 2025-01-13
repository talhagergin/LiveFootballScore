import SwiftUI

struct MatchesView: View {
    let leagueID: Int
    @State private var matchClient = MatchClient()
    @State private var matches: [Match] = []

    // match filter and order
    private func filterAndSortMatches(_ allMatches: [Match]) -> [Match] {
        let now = Date()
        let todayStart = Calendar.current.startOfDay(for: now)
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: todayStart) ?? todayStart

        
        let filteredMatches = allMatches.filter { match in
            if let matchDate = convertDate(match.status.utcTime) {
                return matchDate >= twoDaysAgo && matchDate < Calendar.current.date(byAdding: .day, value: 2, to: todayStart)!
            }
            return false
        }.sorted { match1, match2 in
            guard let date1 = convertDate(match1.status.utcTime),
                  let date2 = convertDate(match2.status.utcTime) else {
                return false
            }
            return date1 < date2
        }
        // first 15 matches
        return Array(filteredMatches.prefix(15))
    }

    private func getMatches(leagueId: Int) async {
        do {
            let allMatches = try await matchClient.getMatches(leagueID: leagueId)
            matches = filterAndSortMatches(allMatches)
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }

    var body: some View {
        List {
            Section(header: Text("Maçlar")) {
                ForEach(matches) { match in
                    VStack (){
                        HStack {
                            Text(match.home.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3)
                            Text("\(match.home.score ?? 0)")
                                .bold()
                            Text(" - ")
                                .bold()
                            Text("\(match.away.score ?? 0)")
                                .bold()
                            Text(match.away.name)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.title3)
                        }
                        HStack {
                            Text(match.status.reason?.long == "Full-Time" ? "Maç Sonucu" : (match.status.reason?.long ?? "Henüz Başlamadı"))

                                .foregroundStyle(match.status.reason?.long == "Full-Time" ? Color.green : Color.blue)

                            Spacer()
                            Text(formatTime(match.status.utcTime))
                                .foregroundStyle(.gray)
                        }
                        Spacer().frame(height: 10)
                    }
                }
            }
        }
        .navigationTitle("Maçlar")
        .onAppear {
            Task {
                await getMatches(leagueId: leagueID)
            }
        }
    }
    
    // UTC string'ini Date'e çevir
    private func convertDate(_ utcTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: utcTime)
    }
    
    // Tarihi formatla
    private func formatTime(_ utcTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: utcTime) {
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            dateFormatter.locale = Locale(identifier: "tr_TR")
            return dateFormatter.string(from: date)
        } else {
            return "Geçersiz Tarih"
        }
    }
}

#Preview {
    MatchesView(leagueID: 71)
}
