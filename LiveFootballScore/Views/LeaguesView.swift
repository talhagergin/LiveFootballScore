//
//  LeaguesView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct LeaguesView: View {
    let countries :[CountryLeagues]
    let teams :[Teams]
    var body: some View {
        List(countries) { country in
            Section(header: Text(country.localizedName)) {
                ForEach(country.leagues) { league in
                    NavigationLink(
                        destination: TeamsTableView(teams: teams)
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
    }
}
/*
#Preview {
    LeaguesView()
}
*/
