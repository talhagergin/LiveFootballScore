//
//  TopPlayersGol.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import Foundation

// Oyuncu takım renklerini tanımlayan model
struct AssistTeamColors: Decodable {
    let darkMode: String
    let lightMode: String
    let fontDarkMode: String
    let fontLightMode: String
}

// Oyuncu modelini tanımlıyoruz
struct PlayerAssist: Decodable, Identifiable {
    let id: Int
    let name: String
    let teamId: Int
    let teamName: String
    let assists: Int
    let teamColors: TeamColors
}


// API yanıtı için ana model
struct APIResponsePlayersAssist: Decodable {
    let status: String
    let response: PlayerAssistResponse
}

// Oyuncuların listesini içeren model
struct PlayerAssistResponse: Decodable {
    let players: [PlayerAssist]
}
