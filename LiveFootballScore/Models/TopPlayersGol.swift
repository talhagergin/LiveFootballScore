//
//  TopPlayersGol.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import Foundation

// Oyuncu takım renklerini tanımlayan model
struct TeamColors: Decodable {
    let darkMode: String
    let lightMode: String
    let fontDarkMode: String
    let fontLightMode: String
}

// Oyuncu modelini tanımlıyoruz
struct Player: Decodable, Identifiable {
    let id: Int
    let name: String
    let teamId: Int
    let teamName: String
    let goals: Int
    let teamColors: TeamColors
}


// API yanıtı için ana model
struct APIResponsePlayers: Decodable {
    let status: String
    let response: PlayerResponse
}

// Oyuncuların listesini içeren model
struct PlayerResponse: Decodable {
    let players: [Player]
}
