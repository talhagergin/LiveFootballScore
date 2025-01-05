//
//  TopPlayersGol.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import Foundation

// Oyuncu takım renklerini tanımlayan model
struct RatingTeamColors: Decodable {
    let darkMode: String
    let lightMode: String
    let fontDarkMode: String
    let fontLightMode: String
}

// Oyuncu modelini tanımlıyoruz
struct PlayerRating: Decodable, Identifiable {
    let id: Int
    let name: String
    let teamId: Int
    let teamName: String
    let rating: Float
    let teamColors: TeamColors
}


// API yanıtı için ana model
struct APIResponsePlayersRating: Decodable {
    let status: String
    let response: PlayerRatingResponse
}

// Oyuncuların listesini içeren model
struct PlayerRatingResponse: Decodable {
    let players: [PlayerRating]
}
