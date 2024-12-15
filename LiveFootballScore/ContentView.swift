//
//  ContentView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var leaguesClient = LeaguesClient()
    @State private var countries: [CountryLeagues] = [] // JSON'dan gelecek ülkeler

        private func getLeaguesByCountry() async {
            do {
                countries = try await leaguesClient.getLeaguesByCountry()
            } catch {
                print("Hata oluştu: \(error.localizedDescription)")
            }
        }

    var body: some View {
            NavigationView {
                List(countries) { country in
                    Section(header: Text(country.localizedName)) { // Ülke başlığı
                        ForEach(country.leagues) { league in // Lig listesi
                            HStack {
                                Text(league.name) // Ligin adı
                                Spacer()
                                AsyncImage(url: URL(string: league.logo)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView() // Görsel yüklenirken spinner
                                }
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            }
                        }
                    }
                }
                .navigationTitle("Ligler")
                .onAppear {
                    Task {
                        await getLeaguesByCountry()
                    }
                }
            }
        }
    }
    


#Preview {
    ContentView()
}
