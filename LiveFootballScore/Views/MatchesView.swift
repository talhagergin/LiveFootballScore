//
//  MatchsView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import SwiftUI

struct MatchesView: View {
    let leagueID: Int
    @State private var matchClient = MatchClient()
    @State private var matches: [Match] = []

    private func getMatches() async {
        do {
           matches = try await matchClient.getMatches()
           
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    var body: some View {
        List {
            Section(header: Text("Maçlar")) {
                ForEach(matches) { match in
                   VStack{
                       HStack{
                           Text(match.home.name).frame(maxWidth: .infinity, alignment: .leading)
                           Text("\(match.home.score)")
                           Text(" - ")
                           Text("\(match.away.score)")
                           Text(match.away.name).frame(maxWidth: .infinity, alignment: .trailing)
                           
                       }
                       HStack{
                           Text(match.status.reason?.long ?? "Maç Devam Ediyor")
                           Spacer()
                           Text(formatTime(match.status.utcTime))
                       }
                   }
                   
                }
            }
        }
        .navigationTitle("Maçlar")
        .onAppear {
            Task {
                await getMatches()
            }
        }
    }
    
    func formatTime(_ utcTime:String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Your input date format
            
            if let date = dateFormatter.date(from: utcTime) {
                dateFormatter.dateFormat = "dd MMM yyyy HH:mm" // Your desired output date format
                return dateFormatter.string(from: date)
            } else {
                return "Geçersiz Tarih"
            }
        }
}

// #Preview {
//     MatchesView()
// }
