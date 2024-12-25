//
//  LeaguesView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct LeaguesView: View {
    //let countries :[CountryLeagues]
    @Binding var selectionTabItem: Int
    @State private var leaguesClient = LeaguesClient()
    @State private var countries: [CountryLeagues] = []
    private func getLeaguesByCountry() async {
        do {
            countries = try await leaguesClient.getLeaguesByCountry()
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
        }
    }
    var body: some View {
        List(countries) { country in
            Section(header: Text(country.localizedName)) {
                ForEach(country.leagues) { league in
                    NavigationLink(
                        destination: TeamsTableView(leagueID: league.id)
                    ){
                        HStack {
                            Text(league.name)
                            Spacer()
                            AsyncImage(url: URL(string: league.logo)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        }
                    }
                   
                }
            }
        }
        .navigationTitle("Ligler")
        .onAppear{
            Task{
                await getLeaguesByCountry()
            }
        }
    }
}
/*
#Preview {
    LeaguesView()
}
*/
