//
//  Fixtures.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

//   let aPIResponsePlayersByTeam = try? JSONDecoder().decode(APIResponsePlayersByTeam.self, from: jsonData)

import Foundation

// MARK: - APIResponsePlayersByTeam
struct APIResponseFixtures: Decodable {
    let status: String
    let response: FixtureResponse
}

// MARK: - Response
struct FixtureResponse: Decodable {
    let matches: [Match]
}

// MARK: - Match
struct Match: Decodable {
    let id, pageURL: String
    let opponent, home, away: Away
    let displayTournament, notStarted: Bool
    let tournament: Tournament
    let status: Status

    enum CodingKeys: String, CodingKey {
        case id
        case pageURL = "pageUrl"
        case opponent, home, away, displayTournament, notStarted, tournament, status
    }
}

// MARK: - Away
struct Away: Codable {
    let id, name: String
    let score: Int
}

// MARK: - Status
struct Status: Codable {
    let utcTime: Date
    let finished, started, cancelled: Bool
    let awarded: Bool?
    let scoreStr: String?
    let reason: Reason?
}

// MARK: - Reason
struct Reason: Codable {
    let short: Short
    let shortKey: ShortKey
    let long: Long
    let longKey: LongKey
}

enum Long: String, Codable {
    case fullTime = "Full-Time"
}

enum LongKey: String, Codable {
    case finished = "finished"
}

enum Short: String, Codable {
    case ft = "FT"
}

enum ShortKey: String, Codable {
    case fulltimeShort = "fulltime_short"
}

// MARK: - Tournament
struct Tournament: Codable {
}
