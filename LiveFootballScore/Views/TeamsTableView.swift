//
//  LeagueDetailsView.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import SwiftUI

struct TeamsTableView: View {
    let teams :[Teams]
    var body: some View {
        List(teams) { team in
                    HStack {
                        Text(team.name)
                        Spacer()
                        AsyncImage(url: URL(string: team.logo)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
        }
        .navigationTitle("Ligler")
    }
}
/*
#Preview {
    TeamsTableView()
}
*/
