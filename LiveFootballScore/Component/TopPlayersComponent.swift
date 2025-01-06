//
//  TopPlayersComponent.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import SwiftUI
protocol TopPlayerItem: Identifiable {
    var name: String { get }
    var teamColors: TeamColors { get }
}

extension Player: TopPlayerItem {}
extension PlayerRating: TopPlayerItem{}
extension PlayerAssist: TopPlayerItem {}

struct TopPlayersComponent<Item: TopPlayerItem>: View {
    var items: [Item] = []
    var title: String

    var body: some View {
        Section(header: Text(title)) {
            ForEach(items) { item in
                HStack {
                    Text(item.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let player = item as? Player {
                        Text("\(player.goals) Gol")
                    } else if let playerAssist = item as? PlayerAssist {
                        Text("\(playerAssist.assists) Asist")
                    }else if let playerRating = item as? PlayerRating{
                        Text(String(format: "%.2f Rating", playerRating.rating))
                    }
                }.foregroundColor(Color(hex: item.teamColors.fontLightMode))
                 .listRowBackground(Color(hex: item.teamColors.lightMode))
            }
        }
    }
}
extension Color {
    init(hex: String) {
        var cleanHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHex = cleanHex.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
/*
#Preview {
    TopPlayersComponent()
}
*/
