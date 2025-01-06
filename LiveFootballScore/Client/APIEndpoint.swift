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
    static let playersURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-list-player?teamid="
    static let playerImageURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-player-logo?playerid="
    static let matchesURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-all-matches-by-league?leagueid="
    static let topPlayersGolURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-top-players-by-goals?leagueid="
    static let topPlayersAssistURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-top-players-by-assists?leagueid="
    static let topPlayersRatingURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-top-players-by-rating?leagueid="
    static let newsURL = "https://free-api-live-football-data.p.rapidapi.com/football-get-trendingnews"
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
