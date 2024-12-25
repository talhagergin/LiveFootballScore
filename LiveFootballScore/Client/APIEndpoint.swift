//
//  Untitled.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 15.12.2024.
//

import Foundation
enum APIEndpoint{
    static let headers = [
        "x-rapidapi-key": "aaab41f623mshfd578203465d8b0p1e23a9jsn2924dd4892b5",
        "x-rapidapi-host": "free-api-live-football-data.p.rapidapi.com"
    ]
    static let baseURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-all-leagues-with-countries"
    static let teamsURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-list-all-team?leagueid="
    /*
    case getLeaguesByCountry(Void)
    case getTeamsByLeagueID(Int)
    private var path:String{
        switch self{
        case .getLeaguesByCountry():
            return APIEndpoint.baseURL
        case .getTeamsByLeagueID(let leagueID):
            return "https://free-api-live-football-data.p.rapidapi.com/football-get-list-all-team?leagueid=\(leagueID)"
        }
    }
     */
}
