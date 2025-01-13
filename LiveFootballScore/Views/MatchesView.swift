import SwiftUI

struct MatchesView: View {
    let leagueID: Int
    @State private var matchClient = MatchClient()
    @State private var allMatches: [Match] = []
    @State private var filteredMatches: [Match] = []
    @State private var selectedDate = Date()

    private func filterMatches() {
        let calendar = Calendar.current

        // Seçilen tarihin başlangıcını al
        let dayStart = calendar.startOfDay(for: selectedDate)

        // Seçilen tarihin sonunu (23:59:59) al
       let dayEnd = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: dayStart)!

        filteredMatches = allMatches.filter { match in
            if let matchDate = convertDate(match.status.utcTime) {
                return matchDate >= dayStart
            }
            return false
        }
        .sorted { match1, match2 in
            guard let date1 = convertDate(match1.status.utcTime),
                  let date2 = convertDate(match2.status.utcTime) else {
                return false
            }
            return date1 < date2
        }
        .prefix(15)
        .map { $0 }
    }


    private func getMatches(leagueId: Int) async {
        do {
            let matches = try await matchClient.getMatches(leagueID: leagueId)
            allMatches = matches
            filterMatches()
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }

    var body: some View {
        VStack {
            DatePicker("Tarih Seçin", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding()
                .onChange(of: selectedDate) { _ in
                    filterMatches()
                }

            List {
                Section(header: Text("Maçlar")) {
                    ForEach(filteredMatches) { match in
                        VStack {
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
    }

    private func convertDate(_ utcTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC olarak ayarlandı
        return dateFormatter.date(from: utcTime)
    }

 private func formatTime(_ utcTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = dateFormatter.date(from: utcTime) {
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
             dateFormatter.timeZone = TimeZone.current
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
