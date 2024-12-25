//
//  Leagues.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import Foundation
struct APIResponse: Decodable {
    let status: String
    let response: LeaguesResponse
}

struct LeaguesResponse: Decodable {
    let leagues: [CountryLeagues]
}

struct CountryLeagues: Decodable, Identifiable {
    var id: String { ccode } 
    let ccode: String
    let name: String
    let localizedName: String
    let leagues: [LeagueDetails]
}

struct LeagueDetails: Decodable, Identifiable {
    let id: Int
    let name: String
    let localizedName: String
    let logo: String
}

